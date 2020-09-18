from sqlalchemy import Column, Date, ForeignKey, Integer, Numeric
from sqlalchemy.orm import relationship
from src.main.python.core.database import base

metadata = base.metadata


class Cohort(base):
    __tablename__ = 'cohort'
    __table_args__ = {'schema': 'cdm_531'}

    cohort_definition_id = Column(ForeignKey('vocab.cohort_definition.cohort_definition_id'), primary_key=True, nullable=False, index=True)
    subject_id = Column(Integer, primary_key=True, nullable=False, index=True)
    cohort_start_date = Column(Date, primary_key=True, nullable=False)
    cohort_end_date = Column(Date, primary_key=True, nullable=False)

    cohort_definition = relationship('CohortDefinition')


class CohortAttribute(base):
    __tablename__ = 'cohort_attribute'
    __table_args__ = {'schema': 'cdm_531'}

    cohort_definition_id = Column(ForeignKey('vocab.cohort_definition.cohort_definition_id'), primary_key=True, nullable=False, index=True)
    cohort_start_date = Column(Date, primary_key=True, nullable=False)
    cohort_end_date = Column(Date, primary_key=True, nullable=False)
    subject_id = Column(Integer, primary_key=True, nullable=False, index=True)
    attribute_definition_id = Column(ForeignKey('vocab.attribute_definition.attribute_definition_id'), primary_key=True, nullable=False)
    value_as_number = Column(Numeric)
    value_as_concept_id = Column(ForeignKey('vocab.concept.concept_id'))

    attribute_definition = relationship('AttributeDefinition')
    cohort_definition = relationship('CohortDefinition')
    value_as_concept = relationship('Concept')


class ConditionEra(base):
    __tablename__ = 'condition_era'
    __table_args__ = {'schema': 'cdm_531'}

    condition_era_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('cdm_531.person.person_id'), nullable=False, index=True)
    condition_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=True)
    condition_era_start_date = Column(Date, nullable=False)
    condition_era_end_date = Column(Date, nullable=False)
    condition_occurrence_count = Column(Integer)

    condition_concept = relationship('Concept')
    person = relationship('Person')


class DoseEra(base):
    __tablename__ = 'dose_era'
    __table_args__ = {'schema': 'cdm_531'}

    dose_era_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('cdm_531.person.person_id'), nullable=False, index=True)
    drug_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=True)
    unit_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    dose_value = Column(Numeric, nullable=False)
    dose_era_start_date = Column(Date, nullable=False)
    dose_era_end_date = Column(Date, nullable=False)

    drug_concept = relationship('Concept', primaryjoin='DoseEra.drug_concept_id == Concept.concept_id')
    person = relationship('Person')
    unit_concept = relationship('Concept', primaryjoin='DoseEra.unit_concept_id == Concept.concept_id')


class DrugEra(base):
    __tablename__ = 'drug_era'
    __table_args__ = {'schema': 'cdm_531'}

    drug_era_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('cdm_531.person.person_id'), nullable=False, index=True)
    drug_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=True)
    drug_era_start_date = Column(Date, nullable=False)
    drug_era_end_date = Column(Date, nullable=False)
    drug_exposure_count = Column(Integer)
    gap_days = Column(Integer)

    drug_concept = relationship('Concept')
    person = relationship('Person')
