"""OMOP CDM metadata tables."""

from sqlalchemy import Column, Date, DateTime, Integer, String, Text
from sqlalchemy.ext.declarative import declared_attr

from ..schema_placeholders import CDM_SCHEMA


class BaseCdmSource:
    __tablename__ = 'cdm_source'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def cdm_source_name(cls):
        return Column(String(255), primary_key=True, nullable=False)

    @declared_attr
    def cdm_source_abbreviation(cls):
        return Column(String(25))

    @declared_attr
    def cdm_holder(cls):
        return Column(String(255))

    @declared_attr
    def source_description(cls):
        return Column(Text)

    @declared_attr
    def source_documentation_reference(cls):
        return Column(String(255))

    @declared_attr
    def cdm_etl_reference(cls):
        return Column(String(255))

    @declared_attr
    def source_release_date(cls):
        return Column(Date)

    @declared_attr
    def cdm_release_date(cls):
        return Column(Date)

    @declared_attr
    def cdm_version(cls):
        return Column(String(10))

    @declared_attr
    def vocabulary_version(cls):
        return Column(String(20))


class BaseMetadata:
    __tablename__ = 'metadata'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def metadata_concept_id(cls):
        return Column(Integer, primary_key=True, nullable=False, index=True)

    @declared_attr
    def metadata_type_concept_id(cls):
        return Column(Integer, primary_key=True, nullable=False)

    @declared_attr
    def name(cls):
        return Column(String(250), primary_key=True, nullable=False)

    @declared_attr
    def value_as_string(cls):
        return Column(Text)

    @declared_attr
    def value_as_concept_id(cls):
        return Column(Integer)

    @declared_attr
    def metadata_date(cls):
        return Column(Date)

    @declared_attr
    def metadata_datetime(cls):
        return Column(DateTime)
