from omop_etl_wrapper.cdm.cdm600.clinical_data import BasePersonCdm600
from sqlalchemy import Column, Integer


# Example
class CustomPerson(BasePersonCdm600):
    custom_field = Column(Integer)
