from sqlalchemy import BigInteger, CHAR, Column, Date, DateTime, ForeignKey, Integer, Numeric, String, Table, Text
from sqlalchemy.orm import relationship
from src.main.python.core.database import base

metadata = base.metadata


class CareSite(base):
    __tablename__ = 'care_site'
    __table_args__ = {'schema': 'cdm_531'}

    care_site_id = Column(Integer, primary_key=True)
    care_site_name = Column(String(255))
    place_of_service_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    location_id = Column(ForeignKey('cdm_531.location.location_id'))
    care_site_source_value = Column(String(50))
    place_of_service_source_value = Column(String(50))

    location = relationship('Location')
    place_of_service_concept = relationship('Concept')


class Location(base):
    __tablename__ = 'location'
    __table_args__ = {'schema': 'cdm_531'}

    location_id = Column(Integer, primary_key=True)
    address_1 = Column(String(50))
    address_2 = Column(String(50))
    city = Column(String(50))
    state = Column(CHAR(2))
    zip = Column(String(9))
    county = Column(String(20))
    location_source_value = Column(String(50))


class Provider(base):
    __tablename__ = 'provider'
    __table_args__ = {'schema': 'cdm_531'}

    provider_id = Column(Integer, primary_key=True)
    provider_name = Column(String(255))
    npi = Column(String(20))
    dea = Column(String(20))
    specialty_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    care_site_id = Column(ForeignKey('cdm_531.care_site.care_site_id'))
    year_of_birth = Column(Integer)
    gender_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    provider_source_value = Column(String(50))
    specialty_source_value = Column(String(50))
    specialty_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))
    gender_source_value = Column(String(50))
    gender_source_concept_id = Column(ForeignKey('vocab.concept.concept_id'))

    care_site = relationship('CareSite')
    gender_concept = relationship('Concept', primaryjoin='Provider.gender_concept_id == Concept.concept_id')
    gender_source_concept = relationship('Concept', primaryjoin='Provider.gender_source_concept_id == Concept.concept_id')
    specialty_concept = relationship('Concept', primaryjoin='Provider.specialty_concept_id == Concept.concept_id')
    specialty_source_concept = relationship('Concept', primaryjoin='Provider.specialty_source_concept_id == Concept.concept_id')
