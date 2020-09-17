import logging
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
