"""Database table utility functions."""

from __future__ import annotations
from types import MappingProxyType
from typing import Union, Callable, Optional, Dict, TYPE_CHECKING

from sqlalchemy import Table

if TYPE_CHECKING:
    from ..database import Database


def table_is_empty(mapped_table: Union[Callable, Table], database: Database) -> bool:
    """
    Check whether a database table contains no records.

    Parameters
    ----------
    mapped_table : mapped table class or sqlalchemy.Table
        A declarative SQLAlchemy table class or Table instance.
    database : Database
        Database in which the table is present.

    Returns
    -------
    bool
        Return True if the table is empty.
    """
    with database.session_scope() as session:
        return session.query(mapped_table).first() is None


def get_full_table_name(table: str,
                        schema: Optional[str],
                        schema_map: Optional[Union[MappingProxyType, Dict[str, str]]] = None
                        ) -> str:
    """
    '.' join schema and table name to get the full table name.

    If schema is not available, return only the table name. Placeholder
    schema names will be replaced according to the schema_map.

    Parameters
    ----------
    table : str
        Table name.
    schema : str, optional
        Schema name.
    schema_map : dict {str : str}, optional
        Schema map dictionary with placeholder names as keys and actual
        schema names as values.

    Returns
    -------
    str
        Full table name if possible, otherwise only the original table
        name.
    """
    if schema is None:
        return table
    if schema_map:
        schema = schema_map.get(schema, schema)
    return '.'.join([schema, table])
