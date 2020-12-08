# Here you define the specifics of your CDM.
# Currently the standard OMOP CDM v5.3.1 is specified, but you can
# customize if needed. See the documentation on defining your CDM for
# more info.

from sqlalchemy import MetaData
from sqlalchemy.ext.declarative import declarative_base

from omop_etl_wrapper.cdm.cdm531.clinical_data import *
from omop_etl_wrapper.cdm.cdm531.health_system_data import *
from omop_etl_wrapper.cdm.cdm531.health_economics import *
from omop_etl_wrapper.cdm.cdm531.derived_elements import *

from omop_etl_wrapper.cdm.vocabularies import *
from omop_etl_wrapper.cdm.metadata import *

from omop_etl_wrapper.database import NAMING_CONVENTION

Base = declarative_base()
Base.metadata = MetaData(naming_convention=NAMING_CONVENTION)


########################################################################
#                            CLINICAL DATA                             #
########################################################################

class Person(BasePersonCdm531, Base):
    pass


class ObservationPeriod(BaseObservationPeriodCdm531, Base):
    pass

# TODO: record_source_value and data_source
class VisitOccurrence(BaseVisitOccurrenceCdm531, Base):
    pass


class VisitDetail(BaseVisitDetailCdm531, Base):
    pass


class ConditionOccurrence(BaseConditionOccurrenceCdm531, Base):
    pass


class DrugExposure(BaseDrugExposureCdm531, Base):
    pass


class ProcedureOccurrence(BaseProcedureOccurrenceCdm531, Base):
    pass


class DeviceExposure(BaseDeviceExposureCdm531, Base):
    pass


class Measurement(BaseMeasurementCdm531, Base):
    pass


class Observation(BaseObservationCdm531, Base):
    pass


class Death(BaseDeathCdm531, Base):
    pass


class Note(BaseNoteCdm531, Base):
    pass


class NoteNlp(BaseNoteNlpCdm531, Base):
    pass


class Specimen(BaseSpecimenCdm531, Base):
    pass


class FactRelationship(BaseFactRelationshipCdm531, Base):
    pass


class StemTable(BaseStemTableCdm531, Base):
    pass


########################################################################
#                          HEALTH SYSTEM DATA                          #
########################################################################


class Location(BaseLocationCdm531, Base):
    pass


class CareSite(BaseCareSiteCdm531, Base):
    pass


class Provider(BaseProviderCdm531, Base):
    pass


########################################################################
#                         HEALTH ECONOMICS DATA                        #
########################################################################


class PayerPlanPeriod(BasePayerPlanPeriodCdm531, Base):
    pass


class Cost(BaseCostCdm531, Base):
    pass


########################################################################
#                    STANDARDIZED DERIVED ELEMENTS                     #
########################################################################


class DrugEra(BaseDrugEraCdm531, Base):
    pass


class DoseEra(BaseDoseEraCdm531, Base):
    pass


class ConditionEra(BaseConditionEraCdm531, Base):
    pass


########################################################################
#                               METADATA                               #
########################################################################


class Metadata(BaseMetadata, Base):
    pass


class CdmSource(BaseCdmSource, Base):
    pass


########################################################################
#                              VOCABULARY                              #
########################################################################


class Concept(BaseConcept, Base):
    pass


class Vocabulary(BaseVocabulary, Base):
    pass


class Domain(BaseDomain, Base):
    pass


class ConceptClass(BaseConceptClass, Base):
    pass


class ConceptRelationship(BaseConceptRelationship, Base):
    pass


class Relationship(BaseRelationship, Base):
    pass


class ConceptSynonym(BaseConceptSynonym, Base):
    pass


class ConceptAncestor(BaseConceptAncestor, Base):
    pass


class SourceToConceptMap(BaseSourceToConceptMap, Base):
    pass


class DrugStrength(BaseDrugStrength, Base):
    pass


# class Cohort(BaseCohortCdm531, Base):
#     pass


# class CohortDefinition(BaseCohortDefinition, Base):
#     pass


########################################################################
#                              EXTENSIONS                              #
########################################################################


# class Episode(BaseEpisodeOncExt, Base):
#     pass
#
#
# class EpisodeEvent(BaseEpisodeEventOncExt, Base):
#     pass
#
#
# # Make sure to remove the regular Measurement class under CLINICAL DATA
# # if using this extension
# class Measurement(BaseMeasurementOncExt, Base):
#     pass
