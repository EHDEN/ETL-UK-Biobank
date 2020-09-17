from sqlalchemy import CHAR, Column, Date, ForeignKey, Integer, Numeric, String, Text
from sqlalchemy.orm import relationship
from src.main.python.core.database import base

metadata = base.metadata


class AttributeDefinition(base):
    __tablename__ = 'attribute_definition'
    __table_args__ = {'schema': 'omopcdm'}

    attribute_definition_id = Column(Integer, primary_key=True, index=True)
    attribute_name = Column(String(255), nullable=False)
    attribute_description = Column(Text)
    attribute_type_concept_id = Column(Integer, nullable=False)
    attribute_syntax = Column(Text)


class CohortDefinition(base):
    __tablename__ = 'cohort_definition'
    __table_args__ = {'schema': 'omopcdm'}

    cohort_definition_id = Column(Integer, primary_key=True, index=True)
    cohort_definition_name = Column(String(255), nullable=False)
    cohort_definition_description = Column(Text)
    definition_type_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'), nullable=False)
    cohort_definition_syntax = Column(Text)
    subject_concept_id = Column(Integer, nullable=False)
    cohort_initiation_date = Column(Date)

    definition_type_concept = relationship('Concept')


class Concept(base):
    __tablename__ = 'concept'
    __table_args__ = {'schema': 'omopcdm'}

    concept_id = Column(Integer, primary_key=True, unique=True)
    concept_name = Column(String(255))
    domain_id = Column(ForeignKey('omopcdm.domain.domain_id'), nullable=False, index=True)
    vocabulary_id = Column(ForeignKey('omopcdm.vocabulary.vocabulary_id'), nullable=False, index=True)
    concept_class_id = Column(ForeignKey('omopcdm.concept_class.concept_class_id'), nullable=False, index=True)
    standard_concept = Column(CHAR(1))
    concept_code = Column(String(50), nullable=False, index=True)
    valid_start_date = Column(Date, nullable=False)
    valid_end_date = Column(Date, nullable=False)
    invalid_reason = Column(CHAR(1))

    concept_class = relationship('ConceptClass', primaryjoin='Concept.concept_class_id == ConceptClass.concept_class_id')
    domain = relationship('Domain', primaryjoin='Concept.domain_id == Domain.domain_id')
    vocabulary = relationship('Vocabulary', primaryjoin='Concept.vocabulary_id == Vocabulary.vocabulary_id')


class ConceptAncestor(base):
    __tablename__ = 'concept_ancestor'
    __table_args__ = {'schema': 'omopcdm'}

    ancestor_concept_id = Column(Integer, primary_key=True, nullable=False, index=True)
    descendant_concept_id = Column(Integer, primary_key=True, nullable=False, index=True)
    min_levels_of_separation = Column(Integer, nullable=False)
    max_levels_of_separation = Column(Integer, nullable=False)


class ConceptClass(base):
    __tablename__ = 'concept_class'
    __table_args__ = {'schema': 'omopcdm'}

    concept_class_id = Column(String(20), primary_key=True, unique=True)
    concept_class_name = Column(String(255), nullable=False)
    concept_class_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'))

    concept_class_concept = relationship('Concept',
                                         primaryjoin='ConceptClass.concept_class_concept_id == Concept.concept_id',
                                         post_update=True)


class ConceptRelationship(base):
    __tablename__ = 'concept_relationship'
    __table_args__ = {'schema': 'omopcdm'}

    concept_id_1 = Column(Integer, primary_key=True, nullable=False, index=True)
    concept_id_2 = Column(Integer, primary_key=True, nullable=False, index=True)
    relationship_id = Column(ForeignKey('omopcdm.relationship.relationship_id'), primary_key=True, nullable=False, index=True)
    valid_start_date = Column(Date, nullable=False)
    valid_end_date = Column(Date, nullable=False)
    invalid_reason = Column(CHAR(1))

    relationship = relationship('Relationship')


class ConceptSynonym(base):
    __tablename__ = 'concept_synonym'
    __table_args__ = {'schema': 'omopcdm'}

    concept_id = Column(ForeignKey('omopcdm.concept.concept_id'), primary_key=True, nullable=False, index=True)
    concept_synonym_name = Column(String(1000), primary_key=True)
    language_concept_id = Column(Integer, nullable=False)

    concept = relationship('Concept', primaryjoin='ConceptSynonym.concept_id == Concept.concept_id', post_update=True)


class Domain(base):
    __tablename__ = 'domain'
    __table_args__ = {'schema': 'omopcdm'}

    domain_id = Column(String(20), primary_key=True, unique=True)
    domain_name = Column(String(255), nullable=False)
    domain_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'))

    domain_concept = relationship('Concept',
                                  primaryjoin='Domain.domain_concept_id == Concept.concept_id',
                                  post_update=True)


class DrugStrength(base):
    __tablename__ = 'drug_strength'
    __table_args__ = {'schema': 'omopcdm'}

    drug_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'), primary_key=True, nullable=False, index=True)
    ingredient_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'), primary_key=True, nullable=False, index=True)
    amount_value = Column(Numeric)
    amount_unit_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'))
    numerator_value = Column(Numeric)
    numerator_unit_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'))
    denominator_value = Column(Numeric)
    denominator_unit_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'))
    box_size = Column(Integer)
    valid_start_date = Column(Date, nullable=False)
    valid_end_date = Column(Date, nullable=False)
    invalid_reason = Column(CHAR(1))

    amount_unit_concept = relationship('Concept', primaryjoin='DrugStrength.amount_unit_concept_id == Concept.concept_id')
    denominator_unit_concept = relationship('Concept', primaryjoin='DrugStrength.denominator_unit_concept_id == Concept.concept_id')
    drug_concept = relationship('Concept', primaryjoin='DrugStrength.drug_concept_id == Concept.concept_id')
    ingredient_concept = relationship('Concept', primaryjoin='DrugStrength.ingredient_concept_id == Concept.concept_id')
    numerator_unit_concept = relationship('Concept', primaryjoin='DrugStrength.numerator_unit_concept_id == Concept.concept_id')


class Relationship(base):
    __tablename__ = 'relationship'
    __table_args__ = {'schema': 'omopcdm'}

    relationship_id = Column(String(20), primary_key=True, unique=True)
    relationship_name = Column(String(255), nullable=False)
    is_hierarchical = Column(CHAR(1), nullable=False)
    defines_ancestry = Column(CHAR(1), nullable=False)
    reverse_relationship_id = Column(ForeignKey('omopcdm.relationship.relationship_id'), nullable=False)
    relationship_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'), nullable=False)

    relationship_concept = relationship('Concept')
    reverse_relationship = relationship('Relationship', remote_side=[relationship_id])


class SourceToConceptMap(base):
    __tablename__ = 'source_to_concept_map'
    __table_args__ = {'schema': 'omopcdm'}

    source_code = Column(String(50), primary_key=True, nullable=False, index=True)
    source_concept_id = Column(Integer, nullable=False)
    source_vocabulary_id = Column(ForeignKey('omopcdm.vocabulary.vocabulary_id'), primary_key=True, nullable=False, index=True)
    source_code_description = Column(String(255))
    target_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'), primary_key=True, nullable=False, index=True)
    target_vocabulary_id = Column(ForeignKey('omopcdm.vocabulary.vocabulary_id'), nullable=False, index=True)
    valid_start_date = Column(Date, nullable=False)
    valid_end_date = Column(Date, primary_key=True, nullable=False)
    invalid_reason = Column(CHAR(1))

    source_vocabulary = relationship('Vocabulary', primaryjoin='SourceToConceptMap.source_vocabulary_id == Vocabulary.vocabulary_id')
    target_concept = relationship('Concept')
    target_vocabulary = relationship('Vocabulary', primaryjoin='SourceToConceptMap.target_vocabulary_id == Vocabulary.vocabulary_id')


class Vocabulary(base):
    __tablename__ = 'vocabulary'
    __table_args__ = {'schema': 'omopcdm'}

    vocabulary_id = Column(String(20), primary_key=True, unique=True)
    vocabulary_name = Column(String(255), nullable=False)
    vocabulary_reference = Column(String(255))
    vocabulary_version = Column(String(255))
    vocabulary_concept_id = Column(ForeignKey('omopcdm.concept.concept_id'))

    vocabulary_concept = relationship('Concept',
                                      primaryjoin='Vocabulary.vocabulary_concept_id == Concept.concept_id',
                                      post_update=True)
