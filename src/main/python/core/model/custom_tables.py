from sqlalchemy import BigInteger, Column, Date, DateTime, ForeignKey, Integer, String
from sqlalchemy.orm import relationship
from src.main.python.core.database import base

metadata = base.metadata


class TreatmentLine(base):
    __tablename__ = 'treatment_line'
    __table_args__ = {'schema': 'cdm_schema'}

    treatment_line_id = Column(Integer, primary_key=True)
    person_id = Column(ForeignKey('cdm_schema.person.person_id'), nullable=False, index=True)
    line_number = Column(Integer, nullable=True)
    total_cycle_number = Column(Integer, nullable=True)
    line_start_date = Column(Date, nullable=True)
    line_end_date = Column(Date, nullable=True)
    drug_concept_id = Column(ForeignKey('vocabulary_schema.concept.concept_id'), index=True)
    drug_era_start_date = Column(Date, nullable=True)
    drug_era_end_date = Column(Date, nullable=True)
    drug_exposure_count = Column(Integer, nullable=True)
    drug_source_value = Column(String(50))
    treatment_type_id = Column(Integer, nullable=True)

    person = relationship('Person')
    drug_concept = relationship('Concept', primaryjoin='TreatmentLine.drug_concept_id == Concept.concept_id')
