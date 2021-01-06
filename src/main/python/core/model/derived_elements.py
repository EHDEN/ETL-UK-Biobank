from sqlalchemy import Column, Date, DateTime, ForeignKey, Integer, Numeric, String, Text, Table
from sqlalchemy.orm import relationship
from src.main.python.core.database import base

metadata = base.metadata


class Cohort(base):
    __tablename__ = 'cohort'
    __table_args__ = {'schema': 'omopcdm'}

    cohort_definition_id = Column(ForeignKey('vocab.cohort_definition.cohort_definition_id'), primary_key=True, nullable=False, index=True)
    subject_id = Column(Integer, primary_key=True, nullable=False, index=True)
    cohort_start_date = Column(Date, primary_key=True, nullable=False)
    cohort_end_date = Column(Date, primary_key=True, nullable=False)

    cohort_definition = relationship('CohortDefinition')


class CohortAttribute(base):
    __tablename__ = 'cohort_attribute'
    __table_args__ = {'schema': 'omopcdm'}

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
    __table_args__ = {'schema': 'omopcdm'}

    condition_era_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=True)
    condition_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=True)
    condition_era_start_date = Column(Date, nullable=False)
    condition_era_end_date = Column(Date, nullable=False)
    condition_occurrence_count = Column(Integer)

    condition_concept = relationship('Concept')
    person = relationship('Person')


class DoseEra(base):
    __tablename__ = 'dose_era'
    __table_args__ = {'schema': 'omopcdm'}

    dose_era_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=True)
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
    __table_args__ = {'schema': 'omopcdm'}

    drug_era_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=True)
    drug_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=True)
    drug_era_start_date = Column(Date, nullable=False)
    drug_era_end_date = Column(Date, nullable=False)
    drug_exposure_count = Column(Integer)
    gap_days = Column(Integer)

    drug_concept = relationship('Concept')
    person = relationship('Person')

class CdmSource(base):
    __tablename__ = 'cdm_source'
    __table_args__ = {'schema': f'omopcdm'}

    cdm_source_name = Column(String(255), primary_key=True)
    cdm_source_abbreviation = Column(String(25))
    cdm_holder = Column(String(255))
    source_description = Column(Text)
    source_documentation_reference = Column(String(255))
    cdm_etl_reference = Column(String(255))
    source_release_date = Column(Date)
    cdm_release_date = Column(Date)
    cdm_version = Column(String(10))
    vocabulary_version = Column(String(20))


t_metadata = Table(
    'metadata', metadata,
    Column('metadata_concept_id', Integer, nullable=False, index=True),
    Column('metadata_type_concept_id', Integer, nullable=False),
    Column('name', String(250), nullable=False),
    Column('value_as_string', Text),
    Column('value_as_concept_id', Integer),
    Column('metadata_date', Date),
    Column('metadata_datetime', DateTime),
    schema=f'omopcdm'
)
