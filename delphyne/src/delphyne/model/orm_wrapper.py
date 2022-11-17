"""ORM wrapper module."""

import logging
import os
from abc import ABC, abstractmethod
from collections import Counter
from functools import lru_cache
from inspect import signature
from typing import Callable, List

from sqlalchemy.orm.session import Session

from .etl_stats import EtlTransformation
from ..database import Database, events

logger = logging.getLogger(__name__)


class OrmWrapper(ABC):
    """
    Wrapper coordinating the execution of python ORM transformations.

    Parameters
    ----------
    database : Database
        Database instance to interact with.
    """

    def __init__(self, database: Database):
        self.db = database

    @property
    @abstractmethod
    def cdm(cls):
        """CDM module."""
        return NotImplementedError('Missing class variable: cdm')

    def run(self):
        """Run ETL procedure."""
        raise NotImplementedError('Method is not implemented')

    @staticmethod
    def is_git_repo() -> bool:
        """
        Check whether current working dir is a git repository.

        Returns
        -------
        bool
            Return True if CWD is a git repository.
        """
        return os.path.exists('./.git')

    def execute_transformation(self, statement: Callable, bulk: bool = False) -> None:
        """
        Execute an ETL transformation via a python statement.

        The statement must return a list of ORM records.

        Parameters
        ----------
        statement : Callable
            Python function which takes this wrapper as input and
            returns a list of records to be inserted.
            It will be called as a transformation.
        bulk : bool
            If True, use SQLAlchemy's bulk_save_objects instead of
            add_all for persisting the ORM objects.

        Returns
        -------
        None
        """
        logger.info(f'Executing transformation: {statement.__name__}')
        with self.db.tracked_session_scope(name=statement.__name__, raise_on_error=False) \
                as (session, transformation_metadata):
            func_args = signature(statement).parameters
            if 'session' in func_args:
                records_to_insert = statement(self, session)
            else:
                records_to_insert = statement(self)
            logger.info(f'Saving {len(records_to_insert)} objects')
            if bulk:
                session.bulk_save_objects(records_to_insert)
                self._collect_transformation_statistics_bulk_mode(session, records_to_insert,
                                                                  transformation_metadata)
            else:
                session.add_all(records_to_insert)

    def execute_batch_transformation(self, batch_statement: Callable, bulk: bool = False,
                                     batch_size: int = 10000) -> None:
        """
        Execute an ETL transformation statement in batches.

        Batches are committed to the database independently and
        a failed insertion of a batch will not trigger
        a rollback of the other batches.

        Parameters
        ----------
        batch_statement : Callable
            Python generator function which takes this wrapper as
            input and yields one record at a time.
            It will be called as a transformation.
        bulk : bool
            If True, use SQLAlchemy's bulk_save_objects instead of
            add_all for persisting the ORM objects.
        batch_size : int
            Number of records inserted in each batch.
            At maximum this number of records is kept in memory.
            Smaller batch sizes will decrease memory use,
            bigger batch sizes will increase insert performance.

        Returns
        -------
        None
        """
        logger.info(f'Executing batched transformation: {batch_statement.__name__} ')

        records_generator = batch_statement(self)

        records_to_insert = []
        batch_count = 0
        n_batches_success = 0
        total_records_inserted = 0
        for record in records_generator:
            records_to_insert.append(record)
            if len(records_to_insert) >= batch_size:
                batch_count += 1
                if self._insert_records(records_to_insert,
                                        batch_statement.__name__ + str(batch_count),
                                        bulk):
                    n_batches_success += 1
                    total_records_inserted += len(records_to_insert)
                    records_to_insert = []

        # Insert any remaining records
        if len(records_to_insert) > 0:
            batch_count += 1
            if self._insert_records(records_to_insert,
                                    batch_statement.__name__ + str(batch_count),
                                    bulk):
                n_batches_success += 1
                total_records_inserted += len(records_to_insert)

        logger.info(f'Saved a total of {total_records_inserted} records in {batch_count} batches')
        logger.info(f'{batch_statement.__name__} completed with status: '
                    f'{n_batches_success} success and {batch_count-n_batches_success} fails')

    def _insert_records(self, records_to_insert: List, name: str, bulk: bool) -> bool:
        with self.db.tracked_session_scope(name=name, raise_on_error=False) \
                as (session, transformation_metadata):
            logger.info(f'{name} Saving {len(records_to_insert)} objects')
            if bulk:
                session.bulk_save_objects(records_to_insert)
                self._collect_transformation_statistics_bulk_mode(session, records_to_insert,
                                                                  transformation_metadata)
            else:
                session.add_all(records_to_insert)
        return transformation_metadata.query_success

    @staticmethod
    def _collect_transformation_statistics_bulk_mode(session: Session,
                                                     records_to_insert: List,
                                                     transformation_metadata: EtlTransformation
                                                     ) -> None:
        # As SQLAlchemy's before_flush listener doesn't work in bulk
        # mode, only deleted and new objects in the record list are
        # counted
        dc = Counter(events.get_record_targets(session.deleted))
        transformation_metadata.deletion_counts = dc
        ic = Counter(events.get_record_targets(records_to_insert))
        transformation_metadata.insertion_counts = ic

