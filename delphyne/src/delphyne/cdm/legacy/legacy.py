"""OMOP CDM legacy tables."""

from sqlalchemy import Column, Date, DateTime, Integer, String, Text, ForeignKey, Numeric
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship

from ..schema_placeholders import CDM_SCHEMA, VOCAB_SCHEMA


class BaseCohort:
    __tablename__ = 'cohort'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def cohort_definition_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.cohort_definition.cohort_definition_id'),
                      primary_key=True, index=True)

    @declared_attr
    def subject_id(cls):
        return Column(Integer, primary_key=True, index=True)

    @declared_attr
    def cohort_start_date(cls):
        return Column(Date, primary_key=True)

    @declared_attr
    def cohort_end_date(cls):
        return Column(Date, primary_key=True)

    @declared_attr
    def cohort_definition(cls):
        return relationship('CohortDefinition')


class BaseCohortDefinition:
    __tablename__ = 'cohort_definition'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def cohort_definition_id(cls):
        return Column(Integer, primary_key=True, index=True)

    @declared_attr
    def cohort_definition_name(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def cohort_definition_description(cls):
        return Column(Text)

    @declared_attr
    def definition_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def cohort_definition_syntax(cls):
        return Column(Text)

    @declared_attr
    def subject_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def cohort_initiation_date(cls):
        return Column(Date)

    @declared_attr
    def definition_type_concept(cls):
        return relationship('Concept', primaryjoin='CohortDefinition.definition_type_concept_id == '
                                                   'Concept.concept_id')

    @declared_attr
    def subject_concept(cls):
        return relationship('Concept', primaryjoin='CohortDefinition.subject_concept_id == '
                                                   'Concept.concept_id')


class BaseCohortAttribute:
    __tablename__ = 'cohort_attribute'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def cohort_definition_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.cohort_definition.cohort_definition_id'),
                      primary_key=True, index=True)

    @declared_attr
    def subject_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def cohort_start_date(cls):
        return Column(Date, primary_key=True)

    @declared_attr
    def cohort_end_date(cls):
        return Column(Date, primary_key=True)

    @declared_attr
    def attribute_definition_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.attribute_definition.attribute_definition_id'),
                      primary_key=True, index=True)

    @declared_attr
    def value_as_number(cls):
        return Column(Numeric)

    @declared_attr
    def value_as_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def cohort_definition(cls):
        return relationship('CohortDefinition')

    @declared_attr
    def attribute_definition(cls):
        return relationship('AttributeDefinition')

    @declared_attr
    def value_as_concept(cls):
        return relationship('Concept')


class BaseAttributeDefinition:
    __tablename__ = 'attribute_definition'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def attribute_definition_id(cls):
        return Column(Integer, primary_key=True, index=True)

    @declared_attr
    def attribute_name(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def attribute_description(cls):
        return Column(Text)

    @declared_attr
    def attribute_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def attribute_syntax(cls):
        return Column(Text)

    @declared_attr
    def attribute_type_concept(cls):
        return relationship('Concept')
