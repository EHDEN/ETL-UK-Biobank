"""OMOP CDM 5.3.1 health economics tables."""

from sqlalchemy import (Column, ForeignKey, Integer, String, Date,
                        Numeric)
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship

from ..schema_placeholders import VOCAB_SCHEMA, CDM_SCHEMA


class BasePayerPlanPeriodCdm531:
    __tablename__ = 'payer_plan_period'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def payer_plan_period_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def person_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.person.person_id'), nullable=False, index=True)

    @declared_attr
    def payer_plan_period_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def payer_plan_period_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def payer_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def payer_source_value(cls):
        return Column(String(50))

    @declared_attr
    def payer_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def plan_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def plan_source_value(cls):
        return Column(String(50))

    @declared_attr
    def plan_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def sponsor_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def sponsor_source_value(cls):
        return Column(String(50))

    @declared_attr
    def sponsor_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def family_source_value(cls):
        return Column(String(50))

    @declared_attr
    def stop_reason_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def stop_reason_source_value(cls):
        return Column(String(50))

    @declared_attr
    def stop_reason_source_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def person(cls):
        return relationship('Person')

    @declared_attr
    def payer_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.payer_concept_id == Concept.concept_id')

    @declared_attr
    def payer_source_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.payer_source_concept_id == '
                                        'Concept.concept_id')

    @declared_attr
    def plan_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.plan_concept_id == Concept.concept_id')

    @declared_attr
    def plan_source_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.plan_source_concept_id == '
                                        'Concept.concept_id')

    @declared_attr
    def sponsor_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.sponsor_concept_id == '
                                        'Concept.concept_id')

    @declared_attr
    def sponsor_source_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.sponsor_source_concept_id == '
                                        'Concept.concept_id')

    @declared_attr
    def stop_reason_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.stop_reason_concept_id == '
                                        'Concept.concept_id')

    @declared_attr
    def stop_reason_source_concept(cls):
        return relationship('Concept',
                            primaryjoin='PayerPlanPeriod.stop_reason_source_concept_id == '
                                        'Concept.concept_id')


class BaseCostCdm531:
    __tablename__ = 'cost'
    __table_args__ = {'schema': CDM_SCHEMA}

    @declared_attr
    def cost_id(cls):
        return Column(Integer, primary_key=True)

    @declared_attr
    def cost_event_id(cls):
        return Column(Integer, nullable=False)

    @declared_attr
    def cost_domain_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.domain.domain_id'), nullable=False)

    @declared_attr
    def cost_type_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def currency_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def total_charge(cls):
        return Column(Numeric)

    @declared_attr
    def total_cost(cls):
        return Column(Numeric)

    @declared_attr
    def total_paid(cls):
        return Column(Numeric)

    @declared_attr
    def paid_by_payer(cls):
        return Column(Numeric)

    @declared_attr
    def paid_by_patient(cls):
        return Column(Numeric)

    @declared_attr
    def paid_patient_copay(cls):
        return Column(Numeric)

    @declared_attr
    def paid_patient_coinsurance(cls):
        return Column(Numeric)

    @declared_attr
    def paid_patient_deductible(cls):
        return Column(Numeric)

    @declared_attr
    def paid_by_primary(cls):
        return Column(Numeric)

    @declared_attr
    def paid_ingredient_cost(cls):
        return Column(Numeric)

    @declared_attr
    def paid_dispensing_fee(cls):
        return Column(Numeric)

    @declared_attr
    def payer_plan_period_id(cls):
        return Column(ForeignKey(f'{CDM_SCHEMA}.payer_plan_period.payer_plan_period_id'))

    @declared_attr
    def amount_allowed(cls):
        return Column(Numeric)

    @declared_attr
    def revenue_code_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def revenue_code_source_value(cls):
        return Column(String(50))

    @declared_attr
    def drg_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def drg_source_value(cls):
        return Column(String(3))

    @declared_attr
    def cost_domain(cls):
        return relationship('Domain')

    @declared_attr
    def cost_type_concept(cls):
        return relationship('Concept',
                            primaryjoin='Cost.cost_type_concept_id == Concept.concept_id')

    @declared_attr
    def currency_concept(cls):
        return relationship('Concept', primaryjoin='Cost.currency_concept_id == Concept.concept_id')

    @declared_attr
    def payer_plan_period(cls):
        return relationship('PayerPlanPeriod')

    @declared_attr
    def revenue_code_concept(cls):
        return relationship('Concept',
                            primaryjoin='Cost.revenue_code_concept_id == Concept.concept_id')

    @declared_attr
    def drg_concept(cls):
        return relationship('Concept', primaryjoin='Cost.drg_concept_id == Concept.concept_id')
