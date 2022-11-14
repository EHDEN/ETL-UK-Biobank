"""
Module for constraint/index operations.

Two different MetaData objects are used within this module. The model
metadata at Database.base.metadata, which contains the table definitions
defined by the user in the template, and the reflected metadata at
Database.reflected_metadata which contains table definitions of what is
actually present in the database. Add-methods use the model metadata,
while drop-methods use the reflected metadata.
"""

from __future__ import annotations

import logging
from copy import copy
from functools import lru_cache, wraps
from typing import TYPE_CHECKING, Union, Dict, Callable, List, Tuple, NamedTuple

from itertools import chain
from sqlalchemy import Index, Table, PrimaryKeyConstraint, Constraint, MetaData, CheckConstraint
from sqlalchemy.engine.reflection import Inspector
from sqlalchemy.exc import NoSuchTableError, SQLAlchemyError
from sqlalchemy.schema import DropConstraint, AddConstraint, DropIndex, CreateIndex

from .conventions import VOCAB_TABLES

if TYPE_CHECKING:
    from ..database import Database

_VALID_ERRORS_OPTIONS = {'raise', 'ignore'}

logger = logging.getLogger(__name__)

ConstraintOrIndex = Union[Constraint, Index]


def _is_non_pk_constraint(constraint: ConstraintOrIndex) -> bool:
    # Return True if constraint is not an index or a PK
    is_constraint = isinstance(constraint, Constraint)
    is_pk = isinstance(constraint, PrimaryKeyConstraint)
    if is_constraint and not is_pk:
        return True
    return False


def _invalidate_db_cache(func: Callable) -> Callable:
    # Decorator to invalidate cached derivatives of reflected MetaData
    @wraps(func)
    def wrapper_invalidate_db_cache(*args, **kwargs):
        ConstraintManager.invalidate_current_db_cache()
        return func(*args, **kwargs)
    return wrapper_invalidate_db_cache


def _create_constraint_lookup(metadata: MetaData) -> Dict[str, ConstraintOrIndex]:
    lookup = {}
    for table in metadata.tables.values():
        for constraint in chain(table.constraints, table.indexes):
            lookup[constraint.name] = constraint
    return lookup


class _ChkConstraint(NamedTuple):
    chk_name: str
    schema_name: str
    table_name: str


class _DbCheckConstraints:
    # Helper class for getting active check constraint via raw SQL
    # queries. Only used when SQLAlchemy does not support reflection of
    # these for the dialect in use.
    def __init__(self, database: Database):
        self._db = database
        self.chk_support = self._check_reflection_support()

#        self._dialect_method_lookup = {
#            'mssql': self._get_chk_constraints_mssql
#        }

    @property
    @lru_cache()
    def all_chk_constraints(self) -> List[_ChkConstraint]:
        pass

    def _check_reflection_support(self) -> bool:
        # Check if SQLAlchemy supports check constraint reflection for
        # the given DBMS
        inspector = Inspector.from_engine(self._db.engine)
        try:
            inspector.get_check_constraints('foo')
        except NotImplementedError:
            return False
        except NoSuchTableError:
            return True
        return True


class _TargetModel:
    """
    Lookup class for table properties of the target model.

    Parameters
    ----------
    metadata : sqlalchemy.MetaData
        Metadata instance of the CDM model.
    """

    def __init__(self, metadata: MetaData):
        self.table_lookup = {t.name: t for t in metadata.tables.values()}
        self.constraint_lookup = _create_constraint_lookup(metadata)
        self.indexes = [c for c in self.constraint_lookup.values()
                        if isinstance(c, Index)]
        self.pks = [c for c in self.constraint_lookup.values()
                    if isinstance(c, PrimaryKeyConstraint)]
        # All non-pk model constraints
        self.constraints = [c for c in self.constraint_lookup.values()
                            if _is_non_pk_constraint(c)]

    def is_model_table(self, table_name: str) -> bool:
        """
        Check table exists within the CDM model MetaData instance.

        Parameters
        ----------
        table_name : str
            Database table name.

        Returns
        -------
        bool
            If table_name is part of the model, return True.
        """
        return table_name in self.table_lookup


class ConstraintManager:
    """
    Manager for adding and removing table constraints/indexes.

    They can be dropped/added individually, per table, for all
    non-vocabulary tables, or for all tables.

    Dropping does not cascade; meaning that if a constraint cannot be
    dropped because another object depends on it, it will remain active.

    Parameters
    ----------
    database : Database
        Database instance to interact with.
    """

    def __init__(self, database: Database):
        self._db = database
        self._model = _TargetModel(metadata=database.base.metadata)
        self._chk_constraints = _DbCheckConstraints(database=database)

    @property
    def _reflected_metadata(self) -> MetaData:
        # return the regular reflected metadata from Database, but
        # inject dummy check constraints if SQLAlchemy doesn't support
        # check constraint reflection for the DBMS
        meta = self._db.reflected_metadata
        if self._chk_constraints.chk_support:
            return meta

    @property
    @lru_cache()
    def _reflected_constraint_lookup(self) -> Dict[str, ConstraintOrIndex]:
        return _create_constraint_lookup(self._reflected_metadata)

    @property
    @lru_cache()
    def _reflected_table_lookup(self) -> Dict[str, Table]:
        return {t.name: t for t in self._reflected_metadata.tables.values()}

    @staticmethod
    def invalidate_current_db_cache() -> None:
        """
        Invalidate table/constraint lookups based on reflected metadata.

        Returns
        -------
        None
        """
        logger.debug('Invalidating database tables cache')
        ConstraintManager._reflected_table_lookup.fget.cache_clear()
        ConstraintManager._reflected_constraint_lookup.fget.cache_clear()
        _DbCheckConstraints.all_chk_constraints.fget.cache_clear()

    def drop_all_constraints(self,
                             drop_constraint: bool = True,
                             drop_pk: bool = True,
                             drop_index: bool = True,
                             errors: str = 'raise',
                             ) -> None:
        """
        Remove constraints/indexes of all tables (including vocabulary).

        Any table bound to your SQLAlchemy Base will be affected. If
        there are any additional tables in your database that are not
        bound to Base, they will not be affected by this method.

        Parameters
        ----------
        drop_constraint : bool, default True
            If True, drop any FK, unique and check constraints.
        drop_pk : bool, default True
            If True, drop all PKs.
        drop_index : bool, default True
            If True, drop all indexes.
        errors : {'ignore', 'raise'}, default 'raise'
            Behavior in case one or more constraints cannot be dropped,
            because dependent objects still exist.
            If 'raise', an exception will be raised upon first
            encountering an object that cannot be dropped.
            If 'ignore', raise no exception and try to drop the
            remaining constraints (if any).

        Returns
        -------
        None
        """
        logger.info('Dropping all constraints')

        tables = [table for table in self._reflected_metadata.tables.values()
                  if self._model.is_model_table(table.name)]

        constraints, pks, indexes = self._get_table_objects(tables, drop_constraint,
                                                            drop_pk, drop_index)

        for constraint in chain(constraints, indexes, pks):
            self._drop_constraint_in_db(constraint, errors)

    @_invalidate_db_cache
    def add_all_constraints(self,
                            add_constraint: bool = True,
                            add_pk: bool = True,
                            add_index: bool = True,
                            errors: str = 'raise',
                            ) -> None:
        """
        Add constraints/indexes of all tables (including vocabulary).

        Any table bound to your SQLAlchemy Base will be affected. If
        there are any additional tables in your database that are not
        bound to Base, they will not be affected by this method.

        If some constraints are already present before this method is
        called, they will remain active and not be added a second time,
        regardless of constraint names.

        Parameters
        ----------
        add_constraint : bool, default True
            If True, add all FK, unique and check constraints.
        add_pk : bool, default True
            If True, add all PKs.
        add_index : bool, default True
            If True, add all indexes.
        errors : {'ignore', 'raise'}, default 'raise'
            Behavior in case one or more constraints cannot be added,
            because prerequisite objects are missing.
            If 'raise', an exception will be raised upon first
            encountering an object that cannot be added.
            If 'ignore', raise no exception and try to add the remaining
            constraints (if any).

        Returns
        -------
        None
        """
        logger.info('Adding all constraints')
        constraints, pks, indexes = [], [], []
        if add_index:
            indexes = self._model.indexes
        if add_pk:
            pks = self._model.pks
        if add_constraint:
            constraints = self._model.constraints

        for constraint in chain(indexes, pks, constraints):
            self._add_constraint_in_db(constraint, errors)

    def drop_cdm_constraints(self,
                             drop_constraint: bool = True,
                             drop_pk: bool = True,
                             drop_index: bool = True,
                             errors: str = 'raise',
                             ) -> None:
        """
        Remove constraints/indexes of all non-vocabulary tables.

        Any table bound to your SQLAlchemy Base that is not an official
        CDM vocabulary table will be affected. If there are any
        additional tables in your database that are not bound to Base,
        they will not be affected by this method.

        Parameters
        ----------
        drop_constraint : bool, default True
            If True, drop any FK, unique and check constraints.
        drop_pk : bool, default True
            If True, drop all PKs.
        drop_index : bool, default True
            If True, drop all indexes.
        errors : {'ignore', 'raise'}, default 'raise'
            Behavior in case one or more constraints cannot be dropped,
            because dependent objects still exist.
            If 'raise', an exception will be raised upon first
            encountering an object that cannot be dropped.
            If 'ignore', raise no exception and try to drop the
            remaining constraints (if any).

        Returns
        -------
        None
        """
        logger.info('Dropping CDM constraints')

        tables = [table for table in self._reflected_metadata.tables.values()
                  if self._model.is_model_table(table.name)
                  and table.name not in VOCAB_TABLES]

        constraints, pks, indexes = self._get_table_objects(tables, drop_constraint,
                                                            drop_pk, drop_index)

        for constraint in chain(constraints, indexes, pks):
            self._drop_constraint_in_db(constraint, errors)

    @_invalidate_db_cache
    def add_cdm_constraints(self,
                            add_constraint: bool = True,
                            add_pk: bool = True,
                            add_index: bool = True,
                            errors: str = 'raise',
                            ) -> None:
        """
        Add constraints/indexes of all non-vocabulary tables.

        Any table bound to your SQLAlchemy Base that is not an official
        CDM vocabulary table will be affected. If there are any
        additional tables in your database that are not bound to Base,
        they will not be affected by this method.

        If some constraints are already present before this method is
        called, they will remain active and not be added a second time,
        regardless of constraint names.

        Parameters
        ----------
        add_constraint : bool, default True
            If True, add all FK, unique and check constraints.
        add_pk : bool, default True
            If True, add all PKs.
        add_index : bool, default True
            If True, add all indexes.
        errors : {'ignore', 'raise'}, default 'raise'
            Behavior in case one or more constraints cannot be added,
            because prerequisite objects are missing.
            If 'raise', an exception will be raised upon first
            encountering an object that cannot be added.
            If 'ignore', raise no exception and try to add the remaining
            constraints (if any).

        Returns
        -------
        None
        """
        logger.info('Adding CDM constraints')
        constraints, pks, indexes = [], [], []
        if add_index:
            indexes = self._model.indexes
        if add_pk:
            pks = self._model.pks
        if add_constraint:
            constraints = self._model.constraints

        for constraint in chain(indexes, pks, constraints):
            if constraint.table.name not in VOCAB_TABLES:
                self._add_constraint_in_db(constraint, errors)

    @_invalidate_db_cache
    def drop_table_constraints(self,
                               table_name: str,
                               drop_constraint: bool = True,
                               drop_pk: bool = True,
                               drop_index: bool = True,
                               errors: str = 'raise',
                               ) -> None:
        """
        Remove constraints/indexes of a CDM table.

        Parameters
        ----------
        table_name : str
            Name of the table, without schema name.
        drop_constraint : bool, default True
            If True, drop any FK, unique and check constraints.
        drop_pk : bool, default True
            If True, drop the PK.
        drop_index : bool, default True
            If True, drop all indexes.
        errors : {'ignore', 'raise'}, default 'raise'
            Behavior in case one or more constraints cannot be dropped,
            because dependent objects still exist.
            If 'raise', an exception will be raised upon first
            encountering an object that cannot be dropped.
            If 'ignore', raise no exception and try to drop the
            remaining constraints for this table (if any).

        Returns
        -------
        None
        """
        logger.info(f'Dropping constraints on table {table_name}')
        table = self._reflected_table_lookup.get(table_name)
        if table is None:
            raise KeyError(f'No table found in database with name "{table_name}"')

        constraints, pks, indexes = self._get_table_objects([table], drop_constraint,
                                                            drop_pk, drop_index)

        for constraint in chain(constraints, indexes, pks):
            self._drop_constraint_in_db(constraint, errors)

    @_invalidate_db_cache
    def add_table_constraints(self,
                              table_name: str,
                              add_constraint: bool = True,
                              add_pk: bool = True,
                              add_index: bool = True,
                              errors: str = 'raise',
                              ) -> None:
        """
        Add constraints/indexes on a CDM table.

        This method requires that the table is bound to your SQLAlchemy
        Base and exists in the database.

        If some constraints are already present on the table before this
        method is called, they will remain active and not be added a
        second time, regardless of constraint names.

        Parameters
        ----------
        table_name : str
            Name of the table, without schema name.
        add_constraint : bool, default True
            If True, add any FK, unique and check constraints.
        add_pk : bool, default True
            Add the table's PK if there is one.
        add_index : bool, default True
            Add all table indexes.
        errors : {'ignore', 'raise'}, default 'raise'
            Behavior in case one or more constraints cannot be added,
            because prerequisite objects are missing.
            If 'raise', an exception will be raised upon first
            encountering an object that cannot be added.
            If 'ignore', raise no exception and try to add the remaining
            constraints for this table (if any).

        Returns
        -------
        None
        """
        logger.info(f'Adding constraints on table {table_name}')
        table = self._model.table_lookup.get(table_name)
        if table is None:
            raise KeyError(f'No table found in model with name "{table_name}"')

        constraints, pks, indexes = self._get_table_objects([table], add_constraint,
                                                            add_pk, add_index)

        for constraint in chain(indexes, pks, constraints):
            self._add_constraint_in_db(constraint, errors)

    @staticmethod
    def _get_table_objects(tables: List[Table],
                           get_constraints: bool,
                           get_pks: bool,
                           get_indexes: bool
                           ) -> Tuple[List[Constraint], List[PrimaryKeyConstraint], List[Index]]:
        # Return the non-pk constraints, pks and indexes of a list of
        # tables.
        # Because we don't know in which order the table constraints can
        # be dropped without violating one in the process, we first
        # collect all of them. They can then safely be dropped in the
        # following order: non-pk constraints, indexes, pks.
        constraints, pks, indexes = [], [], []
        for table in tables:
            for constraint in table.constraints:
                is_pk = isinstance(constraint, PrimaryKeyConstraint)
                if is_pk and get_pks:
                    pks.append(constraint)
                elif not is_pk and get_constraints:
                    constraints.append(constraint)

            if get_indexes:
                for index in table.indexes:
                    indexes.append(index)
        return constraints, pks, indexes

    def _add_constraint_in_db(self,
                              constraint: ConstraintOrIndex,
                              errors: str = 'raise',
                              ) -> None:
        assert errors in _VALID_ERRORS_OPTIONS
        if self._constraint_already_active(constraint):
            return
        if constraint.table.name not in self._reflected_table_lookup:
            logger.warning(f'Cannot add {constraint.name}, '
                           f'table {constraint.table.name} does not exist')
            return
        with self._db.engine.connect() as conn:
            logger.info(f'Adding {constraint.name}')
            try:
                if isinstance(constraint, Index):
                    conn.execute(CreateIndex(constraint))
                else:
                    # We add a copy instead of the original constraint.
                    # Otherwise, when you later call metadata.create_all
                    # to create tables, SQLAlchemy thinks the
                    # constraints have already been created and skips
                    # them.
                    c = copy(constraint)
                    conn.execute(AddConstraint(c))
            except SQLAlchemyError:
                if errors == 'raise':
                    raise
                elif errors == 'ignore':
                    logger.info(f'Unable to add {constraint.name}')

    def _constraint_already_active(self, new_constraint: ConstraintOrIndex) -> bool:
        base_message = f'Cannot add {type(new_constraint).__name__} "{new_constraint.name}"'
        if new_constraint.name in self._reflected_constraint_lookup:
            logger.info(f'{base_message}, a relationship with this name already exists')
            return True
        for constraint in self._reflected_constraint_lookup.values():
            if self._constraints_functionally_equal(constraint, new_constraint):
                logger.info(f'{base_message}, a functional equivalent already exists '
                            f'with name "{constraint.name}"')
                return True
        return False

    def _drop_constraint_in_db(self,
                               constraint: ConstraintOrIndex,
                               errors: str = 'raise',
                               ) -> None:
        # SQLAlchemy reflects empty PK objects in tables that don't have
        # a PK (anymore). These cannot be dropped because they have
        # no name and are therefore ignored here.
        assert errors in _VALID_ERRORS_OPTIONS
        if constraint.name is None:
            return

        with self._db.engine.connect() as conn:
            logger.info(f'Dropping {constraint.name}')
            try:
                if isinstance(constraint, Index):
                    conn.execute(DropIndex(constraint))
                else:
                    conn.execute(DropConstraint(constraint))
            except SQLAlchemyError:
                if errors == 'raise':
                    raise
                elif errors == 'ignore':
                    logger.info(f'Unable to drop {constraint.name}')

    @staticmethod
    def _constraints_functionally_equal(c1: ConstraintOrIndex,
                                        c2: ConstraintOrIndex,
                                        ) -> bool:
        # Check if two constraints/indexes are functional equivalents.
        # This assumes that if they act on the same table and columns
        # (and same column order), they are identical. This works for
        # all regular CDM constraints, but could fall short on custom
        # constraints.
        if not type(c1) == type(c2):
            return False
        if not c1.table.name == c2.table.name:
            return False
        if not {c.name for c in c1.columns} == {c.name for c in c2.columns}:
            return False
        return True
