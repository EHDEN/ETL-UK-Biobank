"""OMOP CDM 6.0.0 clinical tables."""

# This source is a stub

from ..schema_placeholders import VOCAB_SCHEMA, CDM_SCHEMA


class BasePersonCdm600:
    __tablename__ = 'person'
    __table_args__ = {'schema': CDM_SCHEMA}

