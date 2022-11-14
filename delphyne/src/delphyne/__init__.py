"""Top-level package for OMOP ETL Wrapper."""

from ._version import __version__
from .database.database import Database
from .wrapper import Wrapper

__all__ = ['__version__', 'Database', 'Wrapper']
