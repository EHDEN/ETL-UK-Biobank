# Copyright 2020 The Hyve
#
# Licensed under the GNU General Public License, version 3,
# or (at your option) any later version (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

import logging
import os
import re
import time
from pathlib import Path
from typing import Optional, Callable
from sqlalchemy import text
import src.main.python.core.model as cdm
from .code_mapper import CodeMapper


logger = logging.getLogger(__name__)


class EtlWrapper:
    """
    This module coordinates the execution of the python transformations.
    If debug mode is on, the primary key constraints are applied before loading
    to get direct feedback if there are issues. This does make the loading step
    of the ETL significantly slower.
    """

    cdm=cdm

    SOURCE_ROW_COUNT_FORMAT = '{:<60.60} {:>10}'

    def __init__(self, database, config):
        
        self.db = database

        self.n_queries_executed = 0
        self.n_queries_failed = 0
        self.total_rows_inserted = 0

        self.t_start = None
        self.cwd = os.getcwd()

        self.debug = config['run_options']['debug_mode']
        self.code_mapper = CodeMapper(self.db, cdm)

    def run(self):
        """Run ETL procedure"""
        raise NotImplementedError('Method is not implemented')

    # DATABASE OPERATIONS

    # TODO: replace with truncate instead?
    def drop_cdm(self) -> None:
        """Drops clinical tables, if they exist"""
        logger.info('Dropping OMOP CDM (non-vocabulary) tables if existing')
        self.db.base.metadata.drop_all(self.db.engine, tables=[
            self.cdm.clinical_data.StemTable.__table__,
            self.cdm.clinical_data.ConditionOccurrence.__table__,
            self.cdm.clinical_data.DeviceExposure.__table__,
            self.cdm.clinical_data.DrugExposure.__table__,
            self.cdm.clinical_data.FactRelationship.__table__,
            self.cdm.clinical_data.Measurement.__table__,
            self.cdm.clinical_data.Note.__table__,
            self.cdm.clinical_data.NoteNlp.__table__,
            self.cdm.clinical_data.Observation.__table__,
            self.cdm.clinical_data.ObservationPeriod.__table__,
            self.cdm.clinical_data.Death.__table__,
            self.cdm.clinical_data.ProcedureOccurrence.__table__,
            self.cdm.clinical_data.Specimen.__table__,
            self.cdm.clinical_data.VisitDetail.__table__,
            self.cdm.clinical_data.VisitOccurrence.__table__,
            self.cdm.derived_elements.DrugEra.__table__,
            self.cdm.derived_elements.DoseEra.__table__,
            self.cdm.derived_elements.ConditionEra.__table__,
            self.cdm.health_economics.PayerPlanPeriod.__table__,
            self.cdm.health_economics.Cost.__table__,
            self.cdm.clinical_data.Person.__table__,
            self.cdm.health_system_data.Location.__table__,
            self.cdm.health_system_data.CareSite.__table__,
            self.cdm.health_system_data.Provider.__table__,
            self.cdm.derived_elements.CdmSource.__table__
        ])

    def create_cdm(self) -> None:
        """Create the source-specific target metadata table."""
        logger.info('Creating target tables')
        self.db.base.metadata.create_all(self.db.engine)

    # TRANSFORMATION WRAPPERS (Python and SQL)

    def execute_transformation(self, statement: Callable, *args, **kwargs) -> None:
        """
        Execute an ETL transformation via a python statement (function
        that will be called).
        :param statement: Callable
            python function which takes this wrapper as input
        """
        t1 = time.time()

        try:
            records_to_insert = statement(self, *args, **kwargs)
            with self.db.session_scope() as session:
                session.add_all(records_to_insert)
        except Exception as msg:
            if self.debug:
                raise msg
            logger.error("Transformation '%s' failed:" % statement.__name__)
            error = msg.args[0].split('\n')[0]
            logger.error("%s" % error)
            # logger.error(traceback.format_exc(limit=1))
            self.n_queries_failed += 1
            return

        t2 = time.time()

        # NOTE: if multiple queries, then rowcount only last number of inserted/updated rows
        self.log_query_completed(statement, len(records_to_insert), t2 - t1)

        # Note: only tracks row count correctly if 1 insert per file and no update/delete scripts
        if len(records_to_insert) > 0:
            self.total_rows_inserted += len(records_to_insert)

        self.n_queries_executed += 1
        return

    def execute_sql_file(self, file_path, source_schema='public', target_schema='public',
                         print_failed_query=False):

        # Open and read the file as a single buffer
        with open(file_path, 'r') as f:
            query = f.read().strip()

        return self.execute_sql_query(query, source_schema, target_schema, from_file=file_path,
                                      print_failed_query=print_failed_query)

    def execute_sql_query(self, query, source_schema, target_schema,
                          from_file=None, print_failed_query=False):

        # Prepare parameterized sql
        query = query.replace('@absPath', self.cwd)
        query = query.replace("@source_schema", source_schema)
        query = query.replace("@target_schema", target_schema)

        t1 = time.time()

        with self.db.engine.connect() as con:
            try:
                statement = text(query).execution_options(autocommit=True)
                result = con.execute(statement)
            # except SQLAlchemyError as msg:
            except Exception as msg:
                if self.debug:
                    raise msg
                error = msg.args[0].split('\n')[0]
                if from_file:
                    logger.error(f"SQL file: {from_file}")
                logger.error("%s" % error)
                if print_failed_query:
                    logger.error(f"Failed query:\n{query}\n")
                self.n_queries_failed += 1
                return

        t2 = time.time()

        # NOTE: if multiple queries, then rowcount only last number of inserted/updated rows
        self.log_query_completed_sqlquery(query, result.rowcount, t2 - t1)

        # Note: only tracks row count correctly if 1 insert per file and no update/delete scripts
        if result.rowcount > 0 and self.parse_query_type(query) in ['INTO', 'CREATE']:
            self.total_rows_inserted += result.rowcount

        self.n_queries_executed += 1
        return result

    # TRANSFORMATION-RELATED LOGGING

    def log_query_completed(self, py_func, row_count, execution_time=None):
        """ Create message on how many lines inserted into which table """
        if row_count >= 0:
            # NOTE: if multiple queries, then rowcount only last number of inserted/updated rows
            table_into = py_func.__name__
            prefix = ''
            return self.log_table_completed(table_into, row_count, execution_time, prefix)

        return self.log_table_completed(None, row_count, execution_time)

    def log_query_completed_sqlquery(self, sql_query, row_count, execution_time=None):
        """ Create message on how many lines inserted into which table from a SQL script run """
        if row_count >= 0:
            # NOTE: if multiple queries, then rowcount only last number of inserted/updated rows
            table_into = self.parse_target_table_sqlquery(sql_query)
            prefix = self.parse_query_type(sql_query)

            return self.log_table_completed(table_into, row_count, execution_time, prefix)

        return self.log_table_completed(None, row_count, execution_time)

    @staticmethod
    def log_table_completed(table_into, row_count, execution_time, prefix='INTO',
                            show_count_per_record=False):
        if table_into:
            table_into_message = prefix + ' ' + table_into
        else:
            table_into_message = 'Nothing inserted'

        message = '{:<40.40} {:>9,} [{:>8.2f} s'.format(table_into_message, row_count, execution_time)

        if show_count_per_record and row_count > 0:
            message += '| {:>.1e} s/#]'.format(execution_time / row_count)
        else:
            message += ']'

        logger.info(message)

    @staticmethod
    def parse_query_type(query):
        match = re.search(r'^\s*((?:INSERT )?INTO|CREATE TABLE|DELETE\s+FROM|UPDATE)\s+(.+?)\s',
                          query,
                          re.IGNORECASE | re.MULTILINE
                          )
        if match:
            statement = match.group(1).upper()
        else:
            return ''

        if 'INTO' in statement:
            return 'INTO'
        elif 'DELETE' in statement:
            return 'DELETE'
        elif 'CREATE' in statement:
            return 'CREATE'
        elif 'UPDATE' in statement:
            return 'UPDATE'
        else:
            return ''

    @staticmethod
    def parse_target_table_sqlquery(query):
        match = re.search(r'^\s*((?:INSERT )?INTO|CREATE TABLE|DELETE\s+FROM|UPDATE)\s+(.+?)\s',
                          query,
                          re.IGNORECASE | re.MULTILINE
                          )
        if match:
            return match.group(2)
        else:
            return '?'

    # GENERAL LOGGING & STATS

    @staticmethod
    def count_csv_lines(file) -> Optional[int]:
        """
        Counts the line of a .csv file
        :param file: input file
        :return n_rows: number of rows from .csv file, assuming file has header
        """
        try:
            f = open(file)
            n_rows = len(f.readlines()) - 1
            f.close()
        except:
            logger.error(f'Could not read contents of source file: {file}')
            return None

        return n_rows

    def reset_summary_stats(self):
        self.n_queries_executed = 0
        self.n_queries_failed = 0
        self.total_rows_inserted = 0

    @staticmethod
    def log_timestamp():
        logger.info(time.strftime('%a %Y-%m-%d %H:%M:%S'))

    def start_timing(self):
        self.t_start = time.time()

    def log_runtime(self):
        """Prints total execution time on subsequent"""
        total_seconds = time.time() - self.t_start
        m, s = divmod(total_seconds, 60)
        h, m = divmod(m, 60)
        logger.info('Run time: {:>20.1f} seconds ({:>1.0f}:{:>02.0f}:{:>02.0f})'
                    .format(total_seconds, h, m, s))

    def log_summary(self):
        logger.info("Queries/transformations successfully executed: %d" % self.n_queries_executed)
        logger.info("Queries/transformations failed: %d" % self.n_queries_failed)
        logger.info("Rows inserted: {:,}".format(self.total_rows_inserted))

    def log_tables_rowcounts(self, source_data_dir: Path, do_log_total=True):
        """
        Writes the row count of all given source tables from a SQL instance to the log.
        If do_log_total is set to True, it will write the sum of the row counts as well.
        Will ONLY write to file log, not to command line.
        :param source_data_dir: directory containing the source files
        :param do_log_total: boolean, default True
        """
        total = 0

        for path in source_data_dir.glob('*'):
            if path.name.startswith(('.', '~')):
                continue
            total += self.log_table_rowcount(path)

        if len(list(source_data_dir.glob('*'))) > 1 and do_log_total:
            logger.info('+' * (60 + 1 + 10))
            logger.info(self.SOURCE_ROW_COUNT_FORMAT.format('TOTAL', total))

    def log_table_rowcount(self, file_path: Path) -> int:
        """
        Writes the row count of given source table to the log.
        :param file_path: name of the source table
        :return: row count
        """
        is_error = False
        count = None
        try:
            count = self.count_csv_lines(file_path)
        except Exception:
            is_error = True

        if is_error or count is None:
            logger.info(self.SOURCE_ROW_COUNT_FORMAT.format(str(file_path), '-'))
            return 0

        logger.info(self.SOURCE_ROW_COUNT_FORMAT.format(str(file_path), count))
        return count
