"""Source to concept map loading."""

import csv
import logging
from collections import Counter
from functools import lru_cache
from pathlib import Path
from typing import Dict, Set, Optional

from sqlalchemy import MetaData
from sqlalchemy.exc import InvalidRequestError

from ..._paths import STCM_DIR, STCM_VERSION_FILE
from ...cdm.schema_placeholders import VOCAB_SCHEMA
from ...cdm.vocabularies import BaseSourceToConceptMapVersion
from ...database import Database
from ...util.io import get_all_files_in_dir, file_has_valid_prefix

logger = logging.getLogger(__name__)

_STCM_VERSION_TABLE_NAME = BaseSourceToConceptMapVersion.__tablename__


class StcmLoader:
    """
    Loader of source to concept map data into the respective tables.

    Parameters
    ----------
    db : Database
        Database instance to interact with.
    cdm : module
        Module containing all CDM table definitions.
    block_loading : bool
        If True, calls to load tables will be ignored.
    """

    def __init__(self, db: Database, cdm, block_loading: bool):
        self._db = db
        self._cdm = cdm
        self._block_loading = block_loading
        # STCM versions previously loaded into the db
        self._loaded_stcm_versions: Dict[str, str] = {}
        # Newly provided STCM versions from stcm_versions.tsv
        self._provided_stcm_versions: Dict[str, str] = {}

    def load(self) -> None:
        """
        Load STCM files into the source_to_concept_map table.

        Only new STCM mappings, as specified in stcm_versions.tsv, will
        be inserted. All records in the source_to_concept_map table that
        belong to vocabulary_ids that need updating, will be deleted
        before the new records are inserted.

        If an STCM file contains exclusively records of one
        source_vocabulary_id, it can be named as
        <vocab_id>_stcm.<file_extension> to make sure it will not be
        parsed if no new version is available for that vocabulary.

        Returns
        -------
        None
        """
        logger.info(f'Loading source_to_concept_map files: {not self._block_loading}')
        if self._block_loading:
            return
