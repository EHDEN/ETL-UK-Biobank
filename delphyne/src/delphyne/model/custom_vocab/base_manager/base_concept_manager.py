"""concept vocabulary table operations."""

import csv
import logging
from pathlib import Path
from typing import Set, List

from ....database import Database
from ....util.io import get_file_prefix

logger = logging.getLogger(__name__)


class BaseConceptManager:
    """
    Collection of concept vocabulary table functions.

    Parameters
    ----------
    db : Database
        Database instance to interact with.
    cdm : module
        Module containing all CDM table definitions.
    custom_concept_files : list of pathlib.Path
        Collection of files containing custom concept data.
    """

    def __init__(self, db: Database, cdm, custom_concept_files: List[Path]):
        self._db = db
        self._cdm = cdm
        self._custom_concept_files = custom_concept_files

    def _drop_custom_concepts(self, vocab_ids: Set[str]) -> None:
        # Drop concepts associated with a set of custom vocabulary ids
        # from the database

        logging.info(f'Dropping old custom concepts: '
                     f'{True if vocab_ids else False}')

        if not vocab_ids:
            return

        with self._db.tracked_session_scope(name='drop_concepts') as (session, _):
            session.query(self._cdm.Concept) \
                .filter(self._cdm.Concept.vocabulary_id.in_(vocab_ids)) \
                .delete(synchronize_session=False)

    def _load_custom_concepts(self, vocab_ids: Set[str], valid_prefixes: Set[str]) -> None:
        # Load concept_ids associated with a set of custom
        # vocabulary ids to the database

        logging.info(f'Loading new custom concept_ids: '
                     f'{True if vocab_ids else False}')

        if not vocab_ids:
            return

        unique_concepts_check = set()
        vocabs_lowercase = {vocab.lower() for vocab in valid_prefixes}
