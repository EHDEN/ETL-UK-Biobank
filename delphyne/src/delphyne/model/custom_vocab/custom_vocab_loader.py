"""Custom vocabulary loading."""

import logging
from pathlib import Path
from typing import List

from .base_manager import BaseVocabManager, BaseClassManager, BaseConceptManager
from ..._paths import CUSTOM_VOCAB_DIR
from ...database import Database
from ...util.io import get_all_files_in_dir, file_has_valid_prefix

logger = logging.getLogger(__name__)


class CustomVocabLoader(BaseVocabManager, BaseClassManager, BaseConceptManager):
    """
    Loader of custom vocabularies into the respective tables.

    Parameters
    ----------
    db : Database
        Database instance to interact with.
    cdm : module
        Module containing all CDM table definitions.
    block_loading : bool
        If True, calls to load_custom_vocabulary_tables will be
        ignored.
    """

    def __init__(self, db: Database, cdm, block_loading: bool):
        self._db = db
        self._cdm = cdm
        self._block_loading = block_loading
        self._custom_vocab_files: List[str] = []
        self._custom_class_files: List[str] = []
        self._custom_concept_files: List[str] = []

    def _initialize_table_managers(self) -> None:
        if not CUSTOM_VOCAB_DIR.exists():
            raise FileNotFoundError(f'{CUSTOM_VOCAB_DIR.resolve()} folder not found')
        self._custom_vocab_files = self._get_custom_table_files('vocabulary')
        self._custom_class_files = self._get_custom_table_files('concept_class')
        self._custom_concept_files = self._get_custom_table_files('concept')

        BaseVocabManager.__init__(self, db=self._db, cdm=self._cdm,
                                  custom_vocab_files=self._custom_vocab_files)
        BaseClassManager.__init__(self, db=self._db, cdm=self._cdm,
                                  custom_class_files=self._custom_class_files)
        BaseConceptManager.__init__(self, db=self._db, cdm=self._cdm,
                                    custom_concept_files=self._custom_concept_files)

    @staticmethod
    def _get_custom_table_files(omop_table: str) -> List[Path]:
        # Get custom vocab files for a specific vocabulary target table
        # based on the file name conventions (e.g. "concept").
        custom_table_files = get_all_files_in_dir(CUSTOM_VOCAB_DIR)
        return [f for f in custom_table_files if f.stem.lower().endswith(omop_table)]

    def _update_custom_file_list(self, file_list: List[Path], omop_table: str) -> List[Path]:
        # Check if file has either a valid prefix (matching a
        # vocabulary_id to be updated), no prefix, or a prefix
        # unrelated to vocabulary_ids; a valid but mismatching prefix
        # will cause the file to be ignored.
        vocab_ids_all = set(self.vocabs_from_disk.keys())
        return [f for f in file_list
                if file_has_valid_prefix(f, omop_table,
                                         all_prefixes=vocab_ids_all,
                                         valid_prefixes=self._custom_vocabs_to_update)]

    def load(self) -> None:
        """
        Load custom vocabularies to the vocabulary schema.

        - Checks for the presence of custom vocabularies and
          concept_classes at a predefined folder location;
        - Compares the version of custom vocabularies and
          concept_classes in the folder to that of custom vocabularies
          and tables already present in the database;
        - Deletes obsolete versions from the database;
        - Loads the new versions to the database.

        Returns
        -------
        None
        """
        logger.info(f'Loading custom vocabulary tables: {not self._block_loading}')
        if self._block_loading:
            return

        self._initialize_table_managers()
        # check vocabs and classes to drop and update
        self._get_custom_vocabulary_sets()
        self._get_custom_class_sets()
        # get vocab_ids for Concept table operations
        vocabs_to_load = self.vocabs_updated
        vocabs_to_drop = self.vocabs_updated | self.vocabs_unused
        valid_file_prefixes = self.vocabs_from_disk.keys()
        # update list of concept files to parse
        # (not done for vocabulary and concept class files
        # since not particularly large)
        self._custom_concept_files = self._update_custom_file_list(
            self._custom_concept_files, 'concept')
        # drop old versions (unused + updated)
        self._drop_custom_concepts(vocabs_to_drop)
        self._drop_custom_classes()
        self._drop_custom_vocabs()
        # load new versions (update in place)
        self._update_custom_classes()
        # load new versions (create new records)
        self._load_custom_vocabs()
        self._load_custom_classes()
        self._load_custom_concepts(vocabs_to_load, valid_file_prefixes)
