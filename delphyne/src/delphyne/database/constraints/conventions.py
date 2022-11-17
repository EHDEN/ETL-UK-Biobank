"""Database conventions module."""

import inspect
from typing import Set

from ...cdm import vocabularies

# This object should be used to set the naming_convention parameter of
# the SQLAlchemy MetaData object. Using it makes sure that the naming of
# constraints and indexes is deterministic and not left up to the DBMS.
# It's also needed when dropping these, as SQLAlchemy requires that
# they have a name for them to be dropped. See:
# https://docs.sqlalchemy.org/en/13/core/constraints.html#configuring-constraint-naming-conventions
NAMING_CONVENTION = {
    "ix": 'ix_%(table_name)s_%(column_0_N_name)s',
    "uq": "uq_%(table_name)s_%(column_0_name)s",
    "ck": "ck_%(table_name)s_%(constraint_name)s",
    "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
    "pk": "pk_%(table_name)s"
}

# The set of vocabulary table names
VOCAB_TABLES: Set[str] = {m[1].__tablename__
                          for m in inspect.getmembers(vocabularies, inspect.isclass)}
