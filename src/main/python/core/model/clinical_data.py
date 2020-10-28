from sqlalchemy import BigInteger, CHAR, Column, Date, DateTime, ForeignKey, Integer, Numeric, String, Text
from sqlalchemy.orm import relationship
from src.main.python.core.database import base

metadata = base.metadata


class ConditionOccurrence(base):
    __tablename__ = 'condition_occurrence'
    __table_args__ = {'schema': 'omopcdm'}

    condition_occurrence_id = Column(BigInteger, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    condition_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    condition_start_date = Column(Date, nullable=False)
    condition_start_datetime = Column(DateTime, nullable=False)
    condition_end_date = Column(Date)
    condition_end_datetime = Column(DateTime)
    condition_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    stop_reason = Column(String(20))
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    visit_occurrence_id = Column(ForeignKey('omopcdm.visit_occurrence.visit_occurrence_id'), index=False)
    condition_source_value = Column(String(50))
    condition_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    condition_status_source_value = Column(String(50))
    condition_status_concept_id = Column(ForeignKey('vocab.concept.concept_id'))

    condition_concept = relationship('Concept', primaryjoin='ConditionOccurrence.condition_concept_id == Concept.concept_id')
    condition_source_concept = relationship('Concept', primaryjoin='ConditionOccurrence.condition_source_concept_id == Concept.concept_id')
    condition_status_concept = relationship('Concept', primaryjoin='ConditionOccurrence.condition_status_concept_id == Concept.concept_id')
    condition_type_concept = relationship('Concept', primaryjoin='ConditionOccurrence.condition_type_concept_id == Concept.concept_id')
    person = relationship('Person')
    provider = relationship('Provider')
    visit_occurrence = relationship('VisitOccurrence')


class DeviceExposure(base):
    __tablename__ = 'device_exposure'
    __table_args__ = {'schema': 'omopcdm'}

    device_exposure_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    device_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    device_exposure_start_date = Column(Date, nullable=False)
    device_exposure_start_datetime = Column(DateTime, nullable=False)
    device_exposure_end_date = Column(Date)
    device_exposure_end_datetime = Column(DateTime)
    device_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    unique_device_id = Column(String(50))
    quantity = Column(Integer)
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    visit_occurrence_id = Column(ForeignKey('omopcdm.visit_occurrence.visit_occurrence_id'), index=False)
    device_source_value = Column(String(100))
    device_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))

    device_concept = relationship('Concept', primaryjoin='DeviceExposure.device_concept_id == Concept.concept_id')
    device_source_concept = relationship('Concept', primaryjoin='DeviceExposure.device_source_concept_id == Concept.concept_id')
    device_type_concept = relationship('Concept', primaryjoin='DeviceExposure.device_type_concept_id == Concept.concept_id')
    person = relationship('Person')
    provider = relationship('Provider')
    visit_occurrence = relationship('VisitOccurrence')


class DrugExposure(base):
    __tablename__ = 'drug_exposure'
    __table_args__ = {'schema': 'omopcdm'}

    drug_exposure_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    drug_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    drug_exposure_start_date = Column(Date, nullable=False)
    drug_exposure_start_datetime = Column(DateTime)
    drug_exposure_end_date = Column(Date, nullable=False)
    drug_exposure_end_datetime = Column(DateTime)
    verbatim_end_date = Column(Date)
    drug_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    stop_reason = Column(String(20))
    refills = Column(Integer)
    quantity = Column(Numeric)
    days_supply = Column(Integer)
    sig = Column(Text)
    route_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    lot_number = Column(String(50))
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    visit_occurrence_id = Column(ForeignKey('omopcdm.visit_occurrence.visit_occurrence_id'), index=False)
    drug_source_value = Column(String(50))
    drug_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    route_source_value = Column(String(50))
    dose_unit_source_value = Column(String(50))

    drug_concept = relationship('Concept', primaryjoin='DrugExposure.drug_concept_id == Concept.concept_id')
    drug_source_concept = relationship('Concept', primaryjoin='DrugExposure.drug_source_concept_id == Concept.concept_id')
    drug_type_concept = relationship('Concept', primaryjoin='DrugExposure.drug_type_concept_id == Concept.concept_id')
    person = relationship('Person')
    provider = relationship('Provider')
    route_concept = relationship('Concept', primaryjoin='DrugExposure.route_concept_id == Concept.concept_id')
    visit_occurrence = relationship('VisitOccurrence')


class FactRelationship(base):
    __tablename__ = 'fact_relationship'
    __table_args__ = {'schema': 'omopcdm'}

    # TODO: update with appropriate fact relationship logic
    fact_relationship_id = Column(Integer, primary_key=True)
    domain_concept_id_1 = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    domain_concept_id_2 = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    fact_id_1 = Column(Integer, nullable=False)
    fact_id_2 = Column(Integer, nullable=False)
    relationship_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)


class Measurement(base):
    __tablename__ = 'measurement'
    __table_args__ = {'schema': 'omopcdm'}

    measurement_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    measurement_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    measurement_date = Column(Date, nullable=False)
    measurement_datetime = Column(DateTime)
    measurement_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    operator_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    value_as_number = Column(Numeric)
    value_as_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    unit_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    range_low = Column(Numeric)
    range_high = Column(Numeric)
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    visit_occurrence_id = Column(ForeignKey('omopcdm.visit_occurrence.visit_occurrence_id'), index=False)
    measurement_source_value = Column(String(50))
    measurement_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    unit_source_value = Column(String(50))
    value_source_value = Column(String(50))

    measurement_concept = relationship('Concept', primaryjoin='Measurement.measurement_concept_id == Concept.concept_id')
    measurement_source_concept = relationship('Concept', primaryjoin='Measurement.measurement_source_concept_id == Concept.concept_id')
    measurement_type_concept = relationship('Concept', primaryjoin='Measurement.measurement_type_concept_id == Concept.concept_id')
    operator_concept = relationship('Concept', primaryjoin='Measurement.operator_concept_id == Concept.concept_id')
    person = relationship('Person')
    provider = relationship('Provider')
    unit_concept = relationship('Concept', primaryjoin='Measurement.unit_concept_id == Concept.concept_id')
    value_as_concept = relationship('Concept', primaryjoin='Measurement.value_as_concept_id == Concept.concept_id')
    visit_occurrence = relationship('VisitOccurrence')


class Note(base):
    __tablename__ = 'note'
    __table_args__ = {'schema': 'omopcdm'}

    note_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    note_date = Column(Date, nullable=False)
    note_datetime = Column(DateTime)
    note_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    note_class_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    note_title = Column(String(250))
    note_text = Column(Text, nullable=False)
    encoding_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    language_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    visit_occurrence_id = Column(ForeignKey('omopcdm.visit_occurrence.visit_occurrence_id'), index=False)
    note_source_value = Column(String(50))

    encoding_concept = relationship('Concept', primaryjoin='Note.encoding_concept_id == Concept.concept_id')
    language_concept = relationship('Concept', primaryjoin='Note.language_concept_id == Concept.concept_id')
    note_class_concept = relationship('Concept', primaryjoin='Note.note_class_concept_id == Concept.concept_id')
    note_type_concept = relationship('Concept', primaryjoin='Note.note_type_concept_id == Concept.concept_id')
    person = relationship('Person')
    provider = relationship('Provider')
    visit_occurrence = relationship('VisitOccurrence')


class NoteNlp(base):
    __tablename__ = 'note_nlp'
    __table_args__ = {'schema': 'omopcdm'}

    note_nlp_id = Column(BigInteger, primary_key=True)
    note_id = Column(ForeignKey('omopcdm.note.note_id'), nullable=False, index=False)
    section_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    snippet = Column(String(250))
    offset = Column(String(250))
    lexical_variant = Column(String(250), nullable=False)
    note_nlp_concept_id = Column(ForeignKey('vocab.concept.concept_id'), index=False)
    note_nlp_source_concept_id = Column(Integer)
    nlp_system = Column(String(250))
    nlp_date = Column(Date, nullable=False)
    nlp_datetime = Column(DateTime)
    term_exists = Column(CHAR(1))
    term_temporal = Column(String(50))
    term_modifiers = Column(String(2000))

    note = relationship('Note')
    note_nlp_concept = relationship('Concept', primaryjoin='NoteNlp.note_nlp_concept_id == Concept.concept_id')
    section_concept = relationship('Concept', primaryjoin='NoteNlp.section_concept_id == Concept.concept_id')


class Observation(base):
    __tablename__ = 'observation'
    __table_args__ = {'schema': 'omopcdm'}

    observation_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    observation_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    observation_date = Column(Date, nullable=False)
    observation_datetime = Column(DateTime)
    observation_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    value_as_number = Column(Numeric)
    value_as_string = Column(String(60))
    value_as_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    qualifier_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    unit_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    visit_occurrence_id = Column(ForeignKey('omopcdm.visit_occurrence.visit_occurrence_id'), index=False)
    observation_source_value = Column(String(50))
    observation_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    unit_source_value = Column(String(50))
    qualifier_source_value = Column(String(50))

    observation_concept = relationship('Concept', primaryjoin='Observation.observation_concept_id == Concept.concept_id')
    observation_source_concept = relationship('Concept', primaryjoin='Observation.observation_source_concept_id == Concept.concept_id')
    observation_type_concept = relationship('Concept', primaryjoin='Observation.observation_type_concept_id == Concept.concept_id')
    person = relationship('Person')
    provider = relationship('Provider')
    qualifier_concept = relationship('Concept', primaryjoin='Observation.qualifier_concept_id == Concept.concept_id')
    unit_concept = relationship('Concept', primaryjoin='Observation.unit_concept_id == Concept.concept_id')
    value_as_concept = relationship('Concept', primaryjoin='Observation.value_as_concept_id == Concept.concept_id')
    visit_occurrence = relationship('VisitOccurrence')


class ObservationPeriod(base):
    __tablename__ = 'observation_period'
    __table_args__ = {'schema': 'omopcdm'}

    observation_period_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    observation_period_start_date = Column(Date, nullable=False)
    observation_period_end_date = Column(Date, nullable=False)
    period_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)

    period_type_concept = relationship('Concept')
    person = relationship('Person')


class Person(base):
    __tablename__ = 'person'
    __table_args__ = {'schema': 'omopcdm'}

    person_id = Column(Integer, primary_key=True, unique=True)
    gender_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    year_of_birth = Column(Integer, nullable=False)
    month_of_birth = Column(Integer)
    day_of_birth = Column(Integer)
    birth_datetime = Column(DateTime)
    race_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    ethnicity_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    location_id = Column(ForeignKey('omopcdm.location.location_id'))
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    care_site_id = Column(ForeignKey('omopcdm.care_site.care_site_id'))
    person_source_value = Column(String(50))
    gender_source_value = Column(String(50))
    gender_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    race_source_value = Column(String(50))
    race_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    ethnicity_source_value = Column(String(50))
    ethnicity_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))

    care_site = relationship('CareSite')
    ethnicity_concept = relationship('Concept', primaryjoin='Person.ethnicity_concept_id == Concept.concept_id')
    ethnicity_source_concept = relationship('Concept', primaryjoin='Person.ethnicity_source_concept_id == Concept.concept_id')
    gender_concept = relationship('Concept', primaryjoin='Person.gender_concept_id == Concept.concept_id')
    gender_source_concept = relationship('Concept', primaryjoin='Person.gender_source_concept_id == Concept.concept_id')
    location = relationship('Location')
    provider = relationship('Provider')
    race_concept = relationship('Concept', primaryjoin='Person.race_concept_id == Concept.concept_id')
    race_source_concept = relationship('Concept', primaryjoin='Person.race_source_concept_id == Concept.concept_id')


class Death(base):
    __tablename__ = 'death'
    __table_args__ = {'schema': 'omopcdm'}

    person_id = Column(ForeignKey('omopcdm.person.person_id'), primary_key=True, index=False)
    death_date = Column(Date, nullable=True)
    death_datetime = Column(DateTime)
    death_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    cause_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    cause_source_value = Column(String(50))
    cause_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))

    cause_concept = relationship('Concept', primaryjoin='Death.cause_concept_id == Concept.concept_id')
    cause_source_concept = relationship('Concept', primaryjoin='Death.cause_source_concept_id == Concept.concept_id')
    death_type_concept = relationship('Concept', primaryjoin='Death.death_type_concept_id == Concept.concept_id')


class ProcedureOccurrence(base):
    __tablename__ = 'procedure_occurrence'
    __table_args__ = {'schema': 'omopcdm'}

    procedure_occurrence_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    procedure_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    procedure_date = Column(Date, nullable=False)
    procedure_datetime = Column(DateTime, nullable=False)
    procedure_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    modifier_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    quantity = Column(Integer)
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    visit_occurrence_id = Column(ForeignKey('omopcdm.visit_occurrence.visit_occurrence_id'), index=False)
    procedure_source_value = Column(String(50))
    procedure_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    qualifier_source_value = Column(String(50))

    modifier_concept = relationship('Concept', primaryjoin='ProcedureOccurrence.modifier_concept_id == Concept.concept_id')
    person = relationship('Person')
    procedure_concept = relationship('Concept', primaryjoin='ProcedureOccurrence.procedure_concept_id == Concept.concept_id')
    procedure_source_concept = relationship('Concept', primaryjoin='ProcedureOccurrence.procedure_source_concept_id == Concept.concept_id')
    procedure_type_concept = relationship('Concept', primaryjoin='ProcedureOccurrence.procedure_type_concept_id == Concept.concept_id')
    provider = relationship('Provider')
    visit_occurrence = relationship('VisitOccurrence')


class Specimen(base):
    __tablename__ = 'specimen'
    __table_args__ = {'schema': 'omopcdm'}

    specimen_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    specimen_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    specimen_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    specimen_date = Column(Date, nullable=False)
    specimen_datetime = Column(DateTime)
    quantity = Column(Numeric)
    unit_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    anatomic_site_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    disease_status_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    specimen_source_id = Column(String(50))
    specimen_source_value = Column(String(50))
    unit_source_value = Column(String(50))
    anatomic_site_source_value = Column(String(50))
    disease_status_source_value = Column(String(50))

    anatomic_site_concept = relationship('Concept', primaryjoin='Specimen.anatomic_site_concept_id == Concept.concept_id')
    disease_status_concept = relationship('Concept', primaryjoin='Specimen.disease_status_concept_id == Concept.concept_id')
    person = relationship('Person')
    specimen_concept = relationship('Concept', primaryjoin='Specimen.specimen_concept_id == Concept.concept_id')
    specimen_type_concept = relationship('Concept', primaryjoin='Specimen.specimen_type_concept_id == Concept.concept_id')
    unit_concept = relationship('Concept', primaryjoin='Specimen.unit_concept_id == Concept.concept_id')


class VisitOccurrence(base):
    __tablename__ = 'visit_occurrence'
    __table_args__ = {'schema': 'omopcdm'}

    visit_occurrence_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('omopcdm.person.person_id'), nullable=False, index=False)
    visit_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False, index=False)
    visit_start_date = Column(Date, nullable=False)
    visit_start_datetime = Column(DateTime)
    visit_end_date = Column(Date, nullable=False)
    visit_end_datetime = Column(DateTime)
    visit_type_concept_id = Column(ForeignKey('vocab.concept.concept_id'), nullable=False)
    provider_id = Column(ForeignKey('omopcdm.provider.provider_id'))
    care_site_id = Column(ForeignKey('omopcdm.care_site.care_site_id'))
    visit_source_value = Column(String(50))
    visit_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    admitting_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    admitting_source_value = Column(String(50))
    discharge_to_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    discharge_to_source_value = Column(String(50))
    preceding_visit_occurrence_id = Column(Integer)

    admitting_source_concept = relationship('Concept', primaryjoin='VisitOccurrence.admitting_source_concept_id == Concept.concept_id')
    care_site = relationship('CareSite')
    discharge_to_concept = relationship('Concept', primaryjoin='VisitOccurrence.discharge_to_concept_id == Concept.concept_id')
    person = relationship('Person')
    provider = relationship('Provider')
    visit_concept = relationship('Concept', primaryjoin='VisitOccurrence.visit_concept_id == Concept.concept_id')
    visit_source_concept = relationship('Concept', primaryjoin='VisitOccurrence.visit_source_concept_id == Concept.concept_id')
    visit_type_concept = relationship('Concept', primaryjoin='VisitOccurrence.visit_type_concept_id == Concept.concept_id')
