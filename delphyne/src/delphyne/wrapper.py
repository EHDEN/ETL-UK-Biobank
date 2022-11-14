"""Wrapper module."""

import logging
from pathlib import Path
from typing import Optional, List

import sys
from sqlalchemy import Table, inspect
from sqlalchemy.schema import CreateSchema

from ._paths import SOURCE_DATA_CONFIG_PATH
from .cdm import vocabularies as cdm
from .cdm.schema_placeholders import VOCAB_SCHEMA
from .config.models import MainConfig
from .database import Database
from .model.etl_stats import EtlStatsReporter, etl_stats
from .model.mapping import CodeMapper
from .model.orm_wrapper import OrmWrapper
from .model.raw_sql_wrapper import RawSqlWrapper
from .model.source_data import SourceData
from .model.vocab_manager import VocabManager
from .util.io import read_yaml_file

logger = logging.getLogger(__name__)

_HERE = Path(__file__).parent


class Wrapper(OrmWrapper, RawSqlWrapper):
    """
    Task coordinator for converting source data into the OMOP CDM.

    Parameters
    ----------
    config : MainConfig
        The run configuration as read from config.yml.
    cdm_ : module
        Module containing the SQLAlchemy declarative Base
        and the CDM tables.
    """

    cdm = cdm

    def __init__(self, config: MainConfig, cdm_):
        etl_stats.reset()
        self._config = config
        self.db = Database.from_config(config, cdm_.Base)

        if not self.db.can_connect(str(self.db.engine.url)):
            sys.exit()

        super().__init__(database=self.db)
        super(OrmWrapper, self).__init__(database=self.db, config=config)

        self.source_data: Optional[SourceData] = self._set_source_data()
        self.vocab_manager = VocabManager(self.db, cdm_, config)
        self.code_mapper = CodeMapper(self.db, cdm_)

    def _set_source_data(self):
        source_data_path = self._config.source_data_folder
        if source_data_path is None:
            logger.info('No source_data_folder provided in config file, '
                        'assuming no source data files are present')
            return None
        if not SOURCE_DATA_CONFIG_PATH.exists():
            logger.info(f'No source data config file found at {SOURCE_DATA_CONFIG_PATH}, '
                        f'assuming no source data files are present')
            return None
        source_config = read_yaml_file(SOURCE_DATA_CONFIG_PATH)
        source_config['source_data_folder'] = source_data_path
        return SourceData(source_config)

    def _get_cdm_tables_to_drop(self):
        tables_to_drop = []
        for table in self.db.base.metadata.tables.values():
            placeholder_schema = getattr(table, 'schema', None)
            table_schema = self.db.schema_translate_map.get(placeholder_schema)
            if table_schema != self.db.schema_translate_map[VOCAB_SCHEMA]:
                tables_to_drop.append(table)
        return tables_to_drop

    def drop_cdm(self, tables_to_drop: Optional[List[Table]] = None) -> None:
        """
        Drop non-vocabulary tables defined in the ORM (if they exist).

        Parameters
        ----------
        tables_to_drop : list of sqlalchemy.Table, optional
            List of SQLAlchemy table definitions that should be dropped.
            If not provided, all tables that by default are not part of
            the CDM vocabulary tables will be dropped.

        Returns
        -------
        None
        """
        logger.info('Dropping OMOP CDM (non-vocabulary) tables if existing')
        if tables_to_drop is None:
            tables_to_drop = self._get_cdm_tables_to_drop()
        with self.db.engine.connect() as conn:
            self.db.base.metadata.drop_all(bind=conn, tables=tables_to_drop)

    def create_cdm(self) -> None:
        """
        Create all OMOP CDM tables as defined in base.metadata.

        Returns
        -------
        None
        """
        logger.info('Creating OMOP CDM (non-vocabulary) tables')
        with self.db.engine.connect() as conn:
            self.db.base.metadata.create_all(bind=conn)

    def create_schemas(self) -> None:
        """
        Create all schemas used in the SQLAlchemy data model.

        If table definitions include schema names that are present in
        the schema_translate_map, the mapped schema value is used.
        Schemas that already exist remain untouched.

        Returns
        -------
        None
        """
        existing_schemas = inspect(self.db.engine).get_schema_names()
        with self.db.engine.connect() as conn:
            for schema_name in self.db.schemas:
                if schema_name not in existing_schemas:
                    logger.info(f'Creating schema: {schema_name}')
                    conn.execute(CreateSchema(schema_name))

    def summarize(self) -> None:
        """
        Summarize the results of the transformations.

        Logs an overview of all transformations and data sources that
        were used for the current run. If **write_reports** is set to
        True in the main config file, two overview files will be written
        to the logs folder with more detailed information.

        Returns
        -------
        None
        """
        etl_stats_logger = EtlStatsReporter(etl_stats)
        if self._config.run_options.write_reports:
            etl_stats_logger.write_summary_files()
        etl_stats_logger.log_summary()
