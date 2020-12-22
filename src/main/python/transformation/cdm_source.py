from __future__ import annotations
from typing import List, TYPE_CHECKING
from ..core.model.derived_elements import CdmSource
#from ..core.model.vocabularies import Vocabulary
from sqlalchemy.orm.session import Session
from datetime import date

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def cdm_source(wrapper: Wrapper, session=Session) -> List[CdmSource]:
    records = []

    # Get vocabulary info
    #vocab_info = session.query(Vocabulary).filter_by(vocabulary_id='None').one()

    r = CdmSource(
        cdm_source_name='UK_Biobank',
        cdm_etl_reference='https://github.com/EHDEN/ETL-UK-Biobank.git',
        cdm_release_date=date.today(),
        cdm_version='v5.3.1',
        #vocabulary_version=vocab_info.vocabulary_version
    )

    records.append(r)
    return records

