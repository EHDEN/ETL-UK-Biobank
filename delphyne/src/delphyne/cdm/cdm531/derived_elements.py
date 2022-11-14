"""OMOP CDM 5.3.1 derived elements tables."""

from sqlalchemy import Column, ForeignKey, Integer, Date, DateTime, Numeric
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship

from ..schema_placeholders import VOCAB_SCHEMA, CDM_SCHEMA


class BaseConditionEraCdm531:
    __tablename__ = 'condition_era'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def condition_era_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def condition_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def condition_era_start_date(cls):
        return Column(DateTime, nullable=False)

    @declared_attr
    def condition_era_end_date(cls):
        return Column(DateTime, nullable=False)

    @declared_attr
    def condition_occurrence_count(cls):
        return Column(Integer)

    @declared_attr
    def condition_concept(cls):
        return relationship('Concept')

    @declared_attr
    def person(cls):
        return relationship('Person')


class BaseDoseEraCdm531:
    __tablename__ = 'dose_era'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def dose_era_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def drug_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def dose_value(cls):
        return Column(Numeric, nullable=False)

    @declared_attr
    def dose_era_start_date(cls):
        return Column(DateTime, nullable=False)

    @declared_attr
    def dose_era_end_date(cls):
        return Column(DateTime, nullable=False)

    @declared_attr
    def drug_concept(cls):
        return relationship('Concept', primaryjoin='DoseEra.drug_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def unit_concept(cls):
        return relationship('Concept', primaryjoin='DoseEra.unit_concept_id == Concept.concept_id')


class BaseDrugEraCdm531:
    __tablename__ = 'drug_era'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def drug_era_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def drug_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def drug_era_start_date(cls):
        return Column(DateTime, nullable=False)

    @declared_attr
    def drug_era_end_date(cls):
        return Column(DateTime, nullable=False)

    @declared_attr
    def drug_exposure_count(cls):
        return Column(Integer)

    @declared_attr
    def gap_days(cls):
        return Column(Integer)

    @declared_attr
    def drug_concept(cls):
        return relationship('Concept')

    @declared_attr
    def person(cls):
        return relationship('Person')
