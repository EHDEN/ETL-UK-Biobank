from __future__ import annotations

import logging
from getpass import getpass
from typing import Dict
from contextlib import contextmanager

from sqlalchemy import create_engine, MetaData
from sqlalchemy.exc import OperationalError
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy_utils.functions import database_exists

base = declarative_base()

logger = logging.getLogger(__name__)


class Database:
    def __init__(self, uri: str):
        self.engine = create_engine(uri, use_batch_mode=True)
        self.base = base
        self.metadata = self._set_metadata()
        self._sessionmaker = sessionmaker(bind=self.engine)

    def _set_metadata(self) -> MetaData:
        """Reflect existing database tables"""
        metadata = MetaData()
        metadata.reflect(bind=self.engine)
        return metadata

    @classmethod
    def from_config(cls, config: Dict) -> Database:
        """
        Create an instance of Database from a configuration file.

        :param config: Dict
            Contents of the configuration file.
        :return: Database
        """
        db_config = config['database']
        hostname = db_config['host']
        port = db_config['port']
        database = db_config['database_name']
        username = db_config['username']
        password = db_config['password']
        uri = f'postgresql://{username}:{password}@{hostname}:{port}/{database}'
        if not password and Database._password_needed(uri):
            password = getpass('Database password:')
            uri = f'postgresql://{username}:{password}@{hostname}:{port}/{database}'
        return cls(uri=uri)

    @staticmethod
    def _password_needed(uri: str) -> bool:
        logger.disabled = True
        try:
            create_engine(uri).connect()
        except OperationalError as e:
            if 'no password supplied' in str(e):
                return True
        else:
            return False
        finally:
            logger.disabled = False

    def get_new_session(self):
        return self._sessionmaker()

    def close_connection(self):
        self.engine.dispose()

    @staticmethod
    def perform_rollback(session):
        logger.info('Performing rollback')
        session.rollback()
        logger.info('Rollback completed')

    @contextmanager
    def session_scope(self):
        """Provide a transactional scope around a series of operations."""
        session = self.get_new_session()
        try:
            yield session
            session.commit()
        except Exception as e:
            logger.error(e)
            self.perform_rollback(session)
            raise
        finally:
            session.close()

    @staticmethod
    def can_connect(uri: str) -> bool:
        try:
            db_exists = database_exists(uri)
        except OperationalError as e:
            logger.error(e)
            return False
        if not db_exists:
            db_name = uri.rsplit('/', 1)[-1]
            logger.error(f'Could not connect. Database "{db_name}" does not exist')
        return db_exists
