"""OMOP CDM 5.3.1 clinical tables."""

from sqlalchemy import (Column, Date, DateTime, ForeignKey, Integer,
                        Numeric, String, Text)
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship

from ..schema_placeholders import VOCAB_SCHEMA, CDM_SCHEMA


class BaseConditionOccurrenceCdm531:
    __tablename__ = 'condition_occurrence'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def condition_occurrence_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def condition_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def condition_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def condition_start_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def condition_end_date(cls):
        return Column(Date)

    @declared_attr
    def condition_end_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def condition_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def condition_status_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def stop_reason(cls):
        return Column(String(20))

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def condition_source_value(cls):
        return Column(String(50))

    @declared_attr
    def condition_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def condition_status_source_value(cls):
        return Column(String(50))

    @declared_attr
    def condition_concept(cls):
        return relationship('Concept', primaryjoin='ConditionOccurrence.condition_concept_id == Concept.concept_id')

    @declared_attr
    def condition_source_concept(cls):
        return relationship('Concept', primaryjoin='ConditionOccurrence.condition_source_concept_id == Concept.concept_id')

    @declared_attr
    def condition_status_concept(cls):
        return relationship('Concept', primaryjoin='ConditionOccurrence.condition_status_concept_id == Concept.concept_id')

    @declared_attr
    def condition_type_concept(cls):
        return relationship('Concept', primaryjoin='ConditionOccurrence.condition_type_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')


class BaseDeathCdm531:
    __tablename__ = 'death'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), primary_key=True, index=True)

    @declared_attr
    def death_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def death_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def death_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def cause_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def cause_source_value(cls):
        return Column(String(50))

    @declared_attr
    def cause_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def cause_concept(cls):
        return relationship('Concept', primaryjoin='Death.cause_concept_id == Concept.concept_id')

    @declared_attr
    def cause_source_concept(cls):
        return relationship('Concept', primaryjoin='Death.cause_source_concept_id == Concept.concept_id')

    @declared_attr
    def death_type_concept(cls):
        return relationship('Concept', primaryjoin='Death.death_type_concept_id == Concept.concept_id')


class BaseDeviceExposureCdm531:
    __tablename__ = 'device_exposure'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def device_exposure_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def device_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def device_exposure_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def device_exposure_start_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def device_exposure_end_date(cls):
        return Column(Date)

    @declared_attr
    def device_exposure_end_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def device_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def unique_device_id(cls):
        return Column(String(50))

    @declared_attr
    def quantity(cls):
        return Column(Integer)

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def device_source_value(cls):
        return Column(String(50))

    @declared_attr
    def device_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def device_concept(cls):
        return relationship('Concept', primaryjoin='DeviceExposure.device_concept_id == Concept.concept_id')

    @declared_attr
    def device_source_concept(cls):
        return relationship('Concept', primaryjoin='DeviceExposure.device_source_concept_id == Concept.concept_id')

    @declared_attr
    def device_type_concept(cls):
        return relationship('Concept', primaryjoin='DeviceExposure.device_type_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')


class BaseDrugExposureCdm531:
    __tablename__ = 'drug_exposure'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def drug_exposure_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def drug_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def drug_exposure_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def drug_exposure_start_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def drug_exposure_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def drug_exposure_end_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def verbatim_end_date(cls):
        return Column(Date)

    @declared_attr
    def drug_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def stop_reason(cls):
        return Column(String(20))

    @declared_attr
    def refills(cls):
        return Column(Integer)

    @declared_attr
    def quantity(cls):
        return Column(Numeric)

    @declared_attr
    def days_supply(cls):
        return Column(Integer)

    @declared_attr
    def sig(cls):
        return Column(Text)

    @declared_attr
    def route_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def lot_number(cls):
        return Column(String(50))

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def drug_source_value(cls):
        return Column(String(50))

    @declared_attr
    def drug_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def route_source_value(cls):
        return Column(String(50))

    @declared_attr
    def dose_unit_source_value(cls):
        return Column(String(50))

    @declared_attr
    def drug_concept(cls):
        return relationship('Concept', primaryjoin='DrugExposure.drug_concept_id == Concept.concept_id')

    @declared_attr
    def drug_source_concept(cls):
        return relationship('Concept', primaryjoin='DrugExposure.drug_source_concept_id == Concept.concept_id')

    @declared_attr
    def drug_type_concept(cls):
        return relationship('Concept', primaryjoin='DrugExposure.drug_type_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def route_concept(cls):
        return relationship('Concept', primaryjoin='DrugExposure.route_concept_id == Concept.concept_id')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')


class BaseFactRelationshipCdm531:
    __tablename__ = 'fact_relationship'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def domain_concept_id_1(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, nullable=False, index=True)

    @declared_attr
    def fact_id_1(cls):
        return Column(Integer, primary_key=True, nullable=False)

    @declared_attr
    def domain_concept_id_2(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, nullable=False, index=True)

    @declared_attr
    def fact_id_2(cls):
        return Column(Integer, primary_key=True, nullable=False)

    @declared_attr
    def relationship_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, nullable=False, index=True)

    @declared_attr
    def domain_concept_1(cls):
        return relationship('Concept',
                            primaryjoin='FactRelationship.domain_concept_id_1 == '
                                        'Concept.concept_id')

    @declared_attr
    def domain_concept_2(cls):
        return relationship('Concept',
                            primaryjoin='FactRelationship.domain_concept_id_2 == '
                                        'Concept.concept_id')

    @declared_attr
    def relationship_concept(cls):
        return relationship('Concept',
                            primaryjoin='FactRelationship.relationship_concept_id == '
                                        'Concept.concept_id')


class BaseMeasurementCdm531:
    __tablename__ = 'measurement'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def measurement_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def measurement_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def measurement_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def measurement_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def measurement_time(cls):
        return Column(String(10))

    @declared_attr
    def measurement_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def operator_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def value_as_number(cls):
        return Column(Numeric)

    @declared_attr
    def value_as_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def range_low(cls):
        return Column(Numeric)

    @declared_attr
    def range_high(cls):
        return Column(Numeric)

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def measurement_source_value(cls):
        return Column(String(50))

    @declared_attr
    def measurement_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def unit_source_value(cls):
        return Column(String(50))

    @declared_attr
    def value_source_value(cls):
        return Column(String(50))

    @declared_attr
    def measurement_concept(cls):
        return relationship('Concept', primaryjoin='Measurement.measurement_concept_id == Concept.concept_id')

    @declared_attr
    def measurement_source_concept(cls):
        return relationship('Concept', primaryjoin='Measurement.measurement_source_concept_id == Concept.concept_id')

    @declared_attr
    def measurement_type_concept(cls):
        return relationship('Concept', primaryjoin='Measurement.measurement_type_concept_id == Concept.concept_id')

    @declared_attr
    def operator_concept(cls):
        return relationship('Concept', primaryjoin='Measurement.operator_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def unit_concept(cls):
        return relationship('Concept', primaryjoin='Measurement.unit_concept_id == Concept.concept_id')

    @declared_attr
    def value_as_concept(cls):
        return relationship('Concept', primaryjoin='Measurement.value_as_concept_id == Concept.concept_id')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')


class BaseNoteCdm531:
    __tablename__ = 'note'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def note_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def note_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def note_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def note_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def note_class_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def note_title(cls):
        return Column(String(250))

    @declared_attr
    def note_text(cls):
        return Column(Text)

    @declared_attr
    def encoding_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def language_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def note_source_value(cls):
        return Column(String(50))

    @declared_attr
    def encoding_concept(cls):
        return relationship('Concept', primaryjoin='Note.encoding_concept_id == Concept.concept_id')

    @declared_attr
    def language_concept(cls):
        return relationship('Concept', primaryjoin='Note.language_concept_id == Concept.concept_id')

    @declared_attr
    def note_class_concept(cls):
        return relationship('Concept', primaryjoin='Note.note_class_concept_id == Concept.concept_id')

    @declared_attr
    def note_type_concept(cls):
        return relationship('Concept', primaryjoin='Note.note_type_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')


class BaseNoteNlpCdm531:
    __tablename__ = 'note_nlp'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def note_nlp_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def note_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.note.note_id'), nullable=False, index=True)

    @declared_attr
    def section_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def snippet(cls):
        return Column(String(250))

    @declared_attr
    def offset(cls):
        return Column(String(50))

    @declared_attr
    def lexical_variant(cls):
        return Column(String(250), nullable=False)

    @declared_attr
    def note_nlp_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), index=True)

    @declared_attr
    def note_nlp_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def nlp_system(cls):
        return Column(String(250))

    @declared_attr
    def nlp_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def nlp_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def term_exists(cls):
        return Column(String(1))

    @declared_attr
    def term_temporal(cls):
        return Column(String(50))

    @declared_attr
    def term_modifiers(cls):
        return Column(String(2000))

    @declared_attr
    def note(cls):
        return relationship('Note')

    @declared_attr
    def note_nlp_concept(cls):
        return relationship('Concept', primaryjoin='NoteNlp.note_nlp_concept_id == Concept.concept_id')

    @declared_attr
    def note_nlp_source_concept(cls):
        return relationship('Concept', primaryjoin='NoteNlp.note_nlp_source_concept_id == Concept.concept_id')

    @declared_attr
    def section_concept(cls):
        return relationship('Concept', primaryjoin='NoteNlp.section_concept_id == Concept.concept_id')


class BaseObservationCdm531:
    __tablename__ = 'observation'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def observation_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def observation_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def observation_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def observation_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def observation_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def value_as_number(cls):
        return Column(Numeric)

    @declared_attr
    def value_as_string(cls):
        return Column(String(60))

    @declared_attr
    def value_as_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def qualifier_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def observation_source_value(cls):
        return Column(String(50))

    @declared_attr
    def observation_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def unit_source_value(cls):
        return Column(String(50))

    @declared_attr
    def qualifier_source_value(cls):
        return Column(String(50))

    @declared_attr
    def observation_concept(cls):
        return relationship('Concept', primaryjoin='Observation.observation_concept_id == Concept.concept_id')

    @declared_attr
    def observation_source_concept(cls):
        return relationship('Concept', primaryjoin='Observation.observation_source_concept_id == Concept.concept_id')

    @declared_attr
    def observation_type_concept(cls):
        return relationship('Concept', primaryjoin='Observation.observation_type_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def qualifier_concept(cls):
        return relationship('Concept', primaryjoin='Observation.qualifier_concept_id == Concept.concept_id')

    @declared_attr
    def unit_concept(cls):
        return relationship('Concept', primaryjoin='Observation.unit_concept_id == Concept.concept_id')

    @declared_attr
    def value_as_concept(cls):
        return relationship('Concept', primaryjoin='Observation.value_as_concept_id == Concept.concept_id')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')


class BaseObservationPeriodCdm531:
    __tablename__ = 'observation_period'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def observation_period_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def observation_period_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def observation_period_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def period_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def period_type_concept(cls):
        return relationship('Concept')

    @declared_attr
    def person(cls):
        return relationship('Person')


class BasePersonCdm531:
    __tablename__ = 'person'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def person_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def gender_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def year_of_birth(cls):
        return Column(Integer, nullable=False)

    @declared_attr
    def month_of_birth(cls):
        return Column(Integer)

    @declared_attr
    def day_of_birth(cls):
        return Column(Integer)

    @declared_attr
    def birth_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def race_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def ethnicity_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def location_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.location.location_id'))

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def care_site_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.care_site.care_site_id'))

    @declared_attr
    def person_source_value(cls):
        return Column(String(50))

    @declared_attr
    def gender_source_value(cls):
        return Column(String(50))

    @declared_attr
    def gender_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def race_source_value(cls):
        return Column(String(50))

    @declared_attr
    def race_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def ethnicity_source_value(cls):
        return Column(String(50))

    @declared_attr
    def ethnicity_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def care_site(cls):
        return relationship('CareSite')

    @declared_attr
    def ethnicity_concept(cls):
        return relationship('Concept', primaryjoin='Person.ethnicity_concept_id == Concept.concept_id')

    @declared_attr
    def ethnicity_source_concept(cls):
        return relationship('Concept', primaryjoin='Person.ethnicity_source_concept_id == Concept.concept_id')

    @declared_attr
    def gender_concept(cls):
        return relationship('Concept', primaryjoin='Person.gender_concept_id == Concept.concept_id')

    @declared_attr
    def gender_source_concept(cls):
        return relationship('Concept', primaryjoin='Person.gender_source_concept_id == Concept.concept_id')

    @declared_attr
    def location(cls):
        return relationship('Location')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def race_concept(cls):
        return relationship('Concept', primaryjoin='Person.race_concept_id == Concept.concept_id')

    @declared_attr
    def race_source_concept(cls):
        return relationship('Concept', primaryjoin='Person.race_source_concept_id == Concept.concept_id')


class BaseProcedureOccurrenceCdm531:
    __tablename__ = 'procedure_occurrence'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def procedure_occurrence_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def procedure_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def procedure_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def procedure_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def procedure_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def modifier_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def quantity(cls):
        return Column(Integer)

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def procedure_source_value(cls):
        return Column(String(50))

    @declared_attr
    def procedure_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def modifier_source_value(cls):
        return Column(String(50))

    @declared_attr
    def modifier_concept(cls):
        return relationship('Concept', primaryjoin='ProcedureOccurrence.modifier_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def procedure_concept(cls):
        return relationship('Concept', primaryjoin='ProcedureOccurrence.procedure_concept_id == Concept.concept_id')

    @declared_attr
    def procedure_source_concept(cls):
        return relationship('Concept', primaryjoin='ProcedureOccurrence.procedure_source_concept_id == Concept.concept_id')

    @declared_attr
    def procedure_type_concept(cls):
        return relationship('Concept', primaryjoin='ProcedureOccurrence.procedure_type_concept_id == Concept.concept_id')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')


class BaseSpecimenCdm531:
    __tablename__ = 'specimen'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def specimen_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def specimen_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def specimen_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def specimen_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def specimen_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def quantity(cls):
        return Column(Numeric)

    @declared_attr
    def unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def anatomic_site_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def disease_status_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def specimen_source_id(cls):
        return Column(String(50))

    @declared_attr
    def specimen_source_value(cls):
        return Column(String(50))

    @declared_attr
    def unit_source_value(cls):
        return Column(String(50))

    @declared_attr
    def anatomic_site_source_value(cls):
        return Column(String(50))

    @declared_attr
    def disease_status_source_value(cls):
        return Column(String(50))

    @declared_attr
    def anatomic_site_concept(cls):
        return relationship('Concept', primaryjoin='Specimen.anatomic_site_concept_id == Concept.concept_id')

    @declared_attr
    def disease_status_concept(cls):
        return relationship('Concept', primaryjoin='Specimen.disease_status_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def specimen_concept(cls):
        return relationship('Concept', primaryjoin='Specimen.specimen_concept_id == Concept.concept_id')

    @declared_attr
    def specimen_type_concept(cls):
        return relationship('Concept', primaryjoin='Specimen.specimen_type_concept_id == Concept.concept_id')

    @declared_attr
    def unit_concept(cls):
        return relationship('Concept', primaryjoin='Specimen.unit_concept_id == Concept.concept_id')


class BaseVisitDetailCdm531:
    __tablename__ = 'visit_detail'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def visit_detail_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def visit_detail_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def visit_detail_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def visit_detail_start_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def visit_detail_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def visit_detail_end_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def visit_detail_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def care_site_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.care_site.care_site_id'))

    @declared_attr
    def visit_detail_source_value(cls):
        return Column(String(50))

    @declared_attr
    def visit_detail_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def admitting_source_value(cls):
        return Column(String(50))

    @declared_attr
    def admitting_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def discharge_to_source_value(cls):
        return Column(String(50))

    @declared_attr
    def discharge_to_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def preceding_visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def visit_detail_parent_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), nullable=False)

    @declared_attr
    def admitting_source_concept(cls):
        return relationship('Concept', primaryjoin='VisitDetail.admitting_source_concept_id == Concept.concept_id')

    @declared_attr
    def care_site(cls):
        return relationship('CareSite')

    @declared_attr
    def discharge_to_concept(cls):
        return relationship('Concept', primaryjoin='VisitDetail.discharge_to_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def preceding_visit_detail(cls):
        return relationship('VisitDetail', remote_side=[cls.visit_detail_id], primaryjoin='VisitDetail.preceding_visit_detail_id == VisitDetail.visit_detail_id')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def visit_detail_parent(cls):
        return relationship('VisitDetail', remote_side=[cls.visit_detail_id], primaryjoin='VisitDetail.visit_detail_parent_id == VisitDetail.visit_detail_id')

    @declared_attr
    def visit_detail_source_concept(cls):
        return relationship('Concept', primaryjoin='VisitDetail.visit_detail_source_concept_id == Concept.concept_id')

    @declared_attr
    def visit_detail_type_concept(cls):
        return relationship('Concept', primaryjoin='VisitDetail.visit_detail_type_concept_id == Concept.concept_id')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def visit_detail_concept(cls):
        return relationship('Concept', primaryjoin='VisitDetail.visit_detail_concept_id == Concept.concept_id')


class BaseVisitOccurrenceCdm531:
    __tablename__ = 'visit_occurrence'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def visit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def visit_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def visit_start_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def visit_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def visit_end_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def visit_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def care_site_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.care_site.care_site_id'))

    @declared_attr
    def visit_source_value(cls):
        return Column(String(50))

    @declared_attr
    def visit_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def admitting_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def admitting_source_value(cls):
        return Column(String(50))

    @declared_attr
    def discharge_to_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def discharge_to_source_value(cls):
        return Column(String(50))

    @declared_attr
    def preceding_visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'))

    @declared_attr
    def admitting_source_concept(cls):
        return relationship('Concept', primaryjoin='VisitOccurrence.admitting_source_concept_id == Concept.concept_id')

    @declared_attr
    def care_site(cls):
        return relationship('CareSite')

    @declared_attr
    def discharge_to_concept(cls):
        return relationship('Concept', primaryjoin='VisitOccurrence.discharge_to_concept_id == Concept.concept_id')

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def preceding_visit_occurrence(cls):
        return relationship('VisitOccurrence', remote_side=[cls.visit_occurrence_id])

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def visit_source_concept(cls):
        return relationship('Concept', primaryjoin='VisitOccurrence.visit_source_concept_id == Concept.concept_id')

    @declared_attr
    def visit_type_concept(cls):
        return relationship('Concept', primaryjoin='VisitOccurrence.visit_type_concept_id == Concept.concept_id')

    @declared_attr
    def visit_concept(cls):
        return relationship('Concept', primaryjoin='VisitOccurrence.visit_concept_id == Concept.concept_id')


class BaseStemTableCdm531:
    __tablename__ = 'stem_table'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def domain_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.domain.domain_id'),
                      comment='A foreign key identifying the domain this event belongs to.'
                              'The domain drives the target CDM table this event will be '
                              'recorded in. If one is not set, specify a default domain.')

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False, index=True)

    @declared_attr
    def start_date(cls):
        return Column(Date)

    @declared_attr
    def start_datetime(cls):
        return Column(DateTime, nullable=False)

    @declared_attr
    def end_date(cls):
        return Column(Date)

    @declared_attr
    def end_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def verbatim_end_date(cls):
        return Column(Date)

    @declared_attr
    def type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def operator_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def value_as_number(cls):
        return Column(Numeric)

    @declared_attr
    def value_as_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def value_as_string(cls):
        return Column(String(60))

    @declared_attr
    def value_as_datetime(cls):
        return Column(DateTime)

    @declared_attr
    def unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def range_low(cls):
        return Column(Numeric)

    @declared_attr
    def range_high(cls):
        return Column(Numeric)

    @declared_attr
    def provider_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.provider.provider_id'))

    @declared_attr
    def visit_occurrence_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_occurrence.visit_occurrence_id'), index=True)

    @declared_attr
    def visit_detail_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.visit_detail.visit_detail_id'))

    @declared_attr
    def source_value(cls):
        return Column(String(50))

    @declared_attr
    def source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def unit_source_value(cls):
        return Column(String(50))

    @declared_attr
    def value_source_value(cls):
        return Column(String(50))

    @declared_attr
    def stop_reason(cls):
        return Column(String(20))

    @declared_attr
    def refills(cls):
        return Column(Integer)

    @declared_attr
    def quantity(cls):
        return Column(Numeric)

    @declared_attr
    def days_supply(cls):
        return Column(Integer)

    @declared_attr
    def sig(cls):
        return Column(Text)

    @declared_attr
    def route_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def lot_number(cls):
        return Column(String(50))

    @declared_attr
    def route_source_value(cls):
        return Column(String(50))

    @declared_attr
    def dose_unit_source_value(cls):
        return Column(String(50))

    @declared_attr
    def condition_status_source_value(cls):
        return Column(String(50))

    @declared_attr
    def condition_status_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def qualifier_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def qualifier_source_value(cls):
        return Column(String(50))

    @declared_attr
    def modifier_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def unique_device_id(cls):
        return Column(String(50))

    @declared_attr
    def anatomic_site_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def disease_status_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def specimen_source_id(cls):
        return Column(String(50))

    @declared_attr
    def anatomic_site_source_value(cls):
        return Column(String(50))

    @declared_attr
    def disease_status_source_value(cls):
        return Column(String(50))

    @declared_attr
    def modifier_source_value(cls):
        return Column(String(50))

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def provider(cls):
        return relationship('Provider')

    @declared_attr
    def visit_occurrence(cls):
        return relationship('VisitOccurrence')

    @declared_attr
    def concept(cls):
        return relationship('Concept', primaryjoin='StemTable.concept_id == Concept.concept_id')

    @declared_attr
    def source_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.source_concept_id == Concept.concept_id')

    @declared_attr
    def type_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.type_concept_id == Concept.concept_id')

    @declared_attr
    def operator_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.operator_concept_id == Concept.concept_id')

    @declared_attr
    def unit_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.unit_concept_id == Concept.concept_id')

    @declared_attr
    def value_as_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.value_as_concept_id == Concept.concept_id')

    @declared_attr
    def route_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.route_concept_id == Concept.concept_id')

    @declared_attr
    def qualifier_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.qualifier_concept_id == Concept.concept_id')

    @declared_attr
    def modifier_concept(cls):
        return relationship('Concept', primaryjoin='StemTable.modifier_concept_id == Concept.concept_id')

    @declared_attr
    def anatomic_site_concept(cls):
        return relationship('Concept',
                            primaryjoin='StemTable.anatomic_site_concept_id == Concept.concept_id')

    @declared_attr
    def disease_status_concept(cls):
        return relationship('Concept',
                            primaryjoin='StemTable.disease_status_concept_id == Concept.concept_id')

    @declared_attr
    def visit_detail(cls):
        return relationship('VisitDetail')
