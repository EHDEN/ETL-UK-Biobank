"""
OMOP CDM vocabulary tables.

CDM 6.0.0 check constraints are included.
"""

import datetime

from sqlalchemy import (
    Column, Date, ForeignKey, Integer, Numeric, String,
    DateTime, CheckConstraint, VARCHAR,
)
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship

from ..schema_placeholders import VOCAB_SCHEMA


class BaseConcept:
    __tablename__ = 'concept'
    __table_args__ = (
        CheckConstraint("(COALESCE(invalid_reason,'D') in ('D','U'))",
                        name="chk_c_invalid_reason"),
        CheckConstraint("(COALESCE(standard_concept,'C') in ('C','S'))",
                        name="chk_c_standard_concept"),
        CheckConstraint("(concept_code <> '')", name="chk_c_concept_code"),
        CheckConstraint("(concept_name <> '')", name="chk_c_concept_name"),
        {'schema': VOCAB_SCHEMA},
    )

    @declared_attr
    def concept_id(cls):
        return Column(Integer, primary_key=True, autoincrement=False)

    @declared_attr
    def concept_name(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def domain_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.domain.domain_id'), nullable=False, index=True)

    @declared_attr
    def vocabulary_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.vocabulary.vocabulary_id'), nullable=False, index=True)

    @declared_attr
    def concept_class_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept_class.concept_class_id'), nullable=False, index=True)

    @declared_attr
    def standard_concept(cls):
        return Column(String(1))

    @declared_attr
    def concept_code(cls):
        return Column(String(50), nullable=False, index=True)

    @declared_attr
    def valid_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def valid_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def invalid_reason(cls):
        return Column(String(1))

    @declared_attr
    def concept_class(cls):
        return relationship('ConceptClass', primaryjoin='Concept.concept_class_id == ConceptClass.concept_class_id')

    @declared_attr
    def domain(cls):
        return relationship('Domain', primaryjoin='Concept.domain_id == Domain.domain_id')

    @declared_attr
    def vocabulary(cls):
        return relationship('Vocabulary', primaryjoin='Concept.vocabulary_id == Vocabulary.vocabulary_id')


class BaseConceptAncestor:
    __tablename__ = 'concept_ancestor'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def ancestor_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def descendant_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def min_levels_of_separation(cls):
        return Column(Integer, nullable=False)

    @declared_attr
    def max_levels_of_separation(cls):
        return Column(Integer, nullable=False)

    @declared_attr
    def ancestor_concept(cls):
        return relationship('Concept', primaryjoin='ConceptAncestor.ancestor_concept_id == Concept.concept_id')

    @declared_attr
    def descendant_concept(cls):
        return relationship('Concept', primaryjoin='ConceptAncestor.descendant_concept_id == Concept.concept_id')


class BaseConceptClass:
    __tablename__ = 'concept_class'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def concept_class_id(cls):
        return Column(String(20), primary_key=True)

    @declared_attr
    def concept_class_name(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def concept_class_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def concept_class_concept(cls):
        return relationship('Concept', primaryjoin='ConceptClass.concept_class_concept_id == Concept.concept_id')


class BaseConceptRelationship:
    __tablename__ = 'concept_relationship'
    __table_args__ = (
        CheckConstraint("(COALESCE(invalid_reason,'D')='D')", name="chk_cr_invalid_reason"),
        {'schema': VOCAB_SCHEMA},
    )

    @declared_attr
    def concept_id_1(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def concept_id_2(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def relationship_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.relationship.relationship_id'), primary_key=True, index=True)

    @declared_attr
    def valid_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def valid_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def invalid_reason(cls):
        return Column(String(1))

    @declared_attr
    def concept1(cls):
        return relationship('Concept', primaryjoin='ConceptRelationship.concept_id_1 == Concept.concept_id')

    @declared_attr
    def concept2(cls):
        return relationship('Concept', primaryjoin='ConceptRelationship.concept_id_2 == Concept.concept_id')

    @declared_attr
    def relationship(cls):
        return relationship('Relationship')


class BaseConceptSynonym:
    __tablename__ = 'concept_synonym'
    __table_args__ = (
        # UniqueConstraint uq_concept_synonym is not added, because
        # there is already a PK on the same columns
        CheckConstraint("(concept_synonym_name <> '')", name="chk_csyn_concept_synonym_name"),
        {'schema': VOCAB_SCHEMA},
    )

    @declared_attr
    def concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def concept_synonym_name(cls):
        return Column(String(1000), primary_key=True)

    @declared_attr
    def language_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True)

    @declared_attr
    def concept(cls):
        return relationship('Concept', primaryjoin='ConceptSynonym.concept_id == Concept.concept_id')

    @declared_attr
    def language_concept(cls):
        return relationship('Concept', primaryjoin='ConceptSynonym.language_concept_id == Concept.concept_id')


class BaseDomain:
    __tablename__ = 'domain'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def domain_id(cls):
        return Column(String(20), primary_key=True)

    @declared_attr
    def domain_name(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def domain_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def domain_concept(cls):
        return relationship('Concept', primaryjoin='Domain.domain_concept_id == Concept.concept_id', post_update=True)


class BaseDrugStrength:
    __tablename__ = 'drug_strength'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def drug_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def ingredient_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def amount_value(cls):
        return Column(Numeric)

    @declared_attr
    def amount_unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def numerator_value(cls):
        return Column(Numeric)

    @declared_attr
    def numerator_unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def denominator_value(cls):
        return Column(Numeric)

    @declared_attr
    def denominator_unit_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'))

    @declared_attr
    def box_size(cls):
        return Column(Integer)

    @declared_attr
    def valid_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def valid_end_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def invalid_reason(cls):
        return Column(String(1))

    @declared_attr
    def amount_unit_concept(cls):
        return relationship('Concept', primaryjoin='DrugStrength.amount_unit_concept_id == Concept.concept_id')

    @declared_attr
    def denominator_unit_concept(cls):
        return relationship('Concept', primaryjoin='DrugStrength.denominator_unit_concept_id == Concept.concept_id')

    @declared_attr
    def drug_concept(cls):
        return relationship('Concept', primaryjoin='DrugStrength.drug_concept_id == Concept.concept_id')

    @declared_attr
    def ingredient_concept(cls):
        return relationship('Concept', primaryjoin='DrugStrength.ingredient_concept_id == Concept.concept_id')

    @declared_attr
    def numerator_unit_concept(cls):
        return relationship('Concept', primaryjoin='DrugStrength.numerator_unit_concept_id == Concept.concept_id')


class BaseRelationship:
    __tablename__ = 'relationship'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def relationship_id(cls):
        return Column(String(20), primary_key=True)

    @declared_attr
    def relationship_name(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def is_hierarchical(cls):
        return Column(String(1), nullable=False)

    @declared_attr
    def defines_ancestry(cls):
        return Column(String(1), nullable=False)

    @declared_attr
    def reverse_relationship_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.relationship.relationship_id'), nullable=False)

    @declared_attr
    def relationship_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def relationship_concept(cls):
        return relationship('Concept')

    @declared_attr
    def reverse_relationship(cls):
        return relationship('Relationship', remote_side=[cls.relationship_id])


class BaseSourceToConceptMap:
    __tablename__ = 'source_to_concept_map'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def source_code(cls):
        return Column(VARCHAR(1000), primary_key=True, index=True)

    @declared_attr
    def source_concept_id(cls):
        return Column(Integer, nullable=False)

    @declared_attr
    def source_vocabulary_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.vocabulary.vocabulary_id'), primary_key=True, index=True)

    @declared_attr
    def source_code_description(cls):
        return Column(String(255))

    @declared_attr
    def target_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), primary_key=True, index=True)

    @declared_attr
    def target_vocabulary_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.vocabulary.vocabulary_id'), nullable=False, index=True)

    @declared_attr
    def valid_start_date(cls):
        return Column(Date, nullable=False)

    @declared_attr
    def valid_end_date(cls):
        return Column(Date, primary_key=True)

    @declared_attr
    def invalid_reason(cls):
        return Column(String(1))

    @declared_attr
    def source_vocabulary(cls):
        return relationship('Vocabulary', primaryjoin='SourceToConceptMap.source_vocabulary_id == Vocabulary.vocabulary_id')

    @declared_attr
    def target_concept(cls):
        return relationship('Concept')

    @declared_attr
    def target_vocabulary(cls):
        return relationship('Vocabulary', primaryjoin='SourceToConceptMap.target_vocabulary_id == Vocabulary.vocabulary_id')


class BaseVocabulary:
    __tablename__ = 'vocabulary'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def vocabulary_id(cls):
        return Column(String(20), primary_key=True)

    @declared_attr
    def vocabulary_name(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def vocabulary_reference(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def vocabulary_version(cls):
        return Column(String(255))

    @declared_attr
    def vocabulary_concept_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.concept.concept_id'), nullable=False)

    @declared_attr
    def vocabulary_concept(cls):
        return relationship('Concept', primaryjoin='Vocabulary.vocabulary_concept_id == Concept.concept_id', post_update=True)


class BaseSourceToConceptMapVersion:
    __tablename__ = 'source_to_concept_map_version'
    __table_args__ = {'schema': VOCAB_SCHEMA}

    @declared_attr
    def source_vocabulary_id(cls):
        return Column(ForeignKey(f'{VOCAB_SCHEMA}.vocabulary.vocabulary_id'), primary_key=True)

    @declared_attr
    def stcm_version(cls):
        return Column(String(255), nullable=False)

    @declared_attr
    def last_upload_date(cls):
        return Column(DateTime, nullable=False, default=datetime.datetime.utcnow)
