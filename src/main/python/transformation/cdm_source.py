from __future__ import annotations
from typing import List, TYPE_CHECKING
from ..core.model.derived_elements import CdmSource
from ..core.model.vocabularies import Vocabulary
from datetime import date

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def cdm_source(wrapper: Wrapper) -> List[CdmSource]:
    # Get vocabulary info
    with wrapper.db.session_scope() as session:
        vocab_info = session.query(Vocabulary).filter_by(vocabulary_id='None').one()
        vocabulary_version = vocab_info.vocabulary_version

    return [CdmSource(
        cdm_source_name='UK BiobAnk',
        cdm_source_abbreviation='UKB',
        cdm_holder='University College London',
        source_description='UK Biobank is a large-scale biomedical database and research resource, containing in-depth genetic and health information from half a million UK participants. The database is regularly augmented with additional data and is globally accessible to approved researchers undertaking vital research into the most common and life-threatening diseases. It is a major contributor to the advancement of modern medicine and treatment and has enabled several scientific discoveries that improve human health.',
        source_documentation_reference='https://biobank.ctsu.ox.ac.uk/crystal/index.cgi',
        cdm_etl_reference='https://github.com/EHDEN/ETL-UK-Biobank.git',
        cdm_release_date=date.today(),
        cdm_version='v5.3.1',
        vocabulary_version=vocabulary_version
    )]
