"""concept_class vocabulary table operations."""

import csv
import logging
from collections import Counter
from pathlib import Path
from typing import List, Dict

from ....database import Database

logger = logging.getLogger(__name__)


class BaseClassManager:
    """
    Collection of concept_class vocabulary table functions.

    Parameters
    ----------
    db : Database
        Database instance to interact with.
    cdm : module
        Module containing all CDM table definitions.
    custom_class_files : list of pathlib.Path
        Collection of files containing custom concept_class data.
    """

    def __init__(self, db: Database, cdm, custom_class_files: List[Path]):
        self._db = db
        self._cdm = cdm
        self._custom_class_files = custom_class_files
        self._custom_classes_to_update = set()
        self._custom_classes_to_create = set()
        self._custom_classes_unused = set()

    def _get_custom_class_sets(self) -> None:
        # Compare custom concept_class ids and names
        # to the ones already present in the database.
        #
        # Retrieves:
        # - set of custom concept_classes to be updated in place
        #   (same id, new name)
        # - set of custom concept_classes to be created
        #   (new id)
        # - a set of obsolete custom concept_classes to be removed
        #   (id is not in use anymore)

        logging.info('Looking for new custom class versions')

        classes_old = self._get_old_custom_classes_from_database()
        classes_new = self._get_new_custom_classes_from_disk()

        classes_to_create = set()
        classes_to_update = set()

        self._custom_classes_to_update = classes_to_update
        self._custom_classes_to_create = classes_to_create
        if not self._custom_classes_to_update and not self._custom_classes_to_create:
            logging.info('No new concept_class version found on disk')

        logging.info('Looking for unused custom concept_class versions')

        self._custom_classes_unused = classes_old.keys() - classes_new.keys()

        for old_id in self._custom_classes_unused:
            logging.info(f'Found obsolete class version: {old_id}')

        if not self._custom_classes_unused:
            logging.info('No obsolete version found in database')

    def _get_old_custom_classes_from_database(self) -> Dict[str, str]:
        # Retrieve all custom concept_classes
        # (concept_class_concept_id == 0)
        # currently in database and return a dictionary {id : name}.

        class_dict = {}

        with self._db.session_scope() as session:

            records = session.query(self._cdm.ConceptClass) \
                .filter(self._cdm.ConceptClass.concept_class_concept_id == 0) \
                .all()

            for record in records:
                class_dict[record.concept_class_id] = record.concept_class_name

        return class_dict

    def _get_new_custom_classes_from_disk(self) -> Dict[str, str]:
        # Retrieve all user-provided custom concept_classes from disk
        # and return a dictionary {id : name}.

        class_dict = {}

        return class_dict

    def _drop_custom_classes(self) -> None:
        # Drop obsolete custom concept_classes from the database

        classes_to_drop = self._custom_classes_unused

        logging.info(f'Dropping unused custom concept_class versions: '
                     f'{True if classes_to_drop else False}')

        if not classes_to_drop:
            return

    def _load_custom_classes(self) -> None:
        # Load new custom concept_classes to the database

        classes_to_create = self._custom_classes_to_create

        logging.info(f'Loading new custom classes: '
                     f'{True if classes_to_create else False}')

        if not classes_to_create:
            return

    def _update_custom_classes(self) -> None:
        # Update the name of existing custom concept_classes in the
        # database

        classes_to_update = self._custom_classes_to_update

        logging.info(f'Updating custom class names: '
                     f'{True if classes_to_update else False}')

        if not classes_to_update:
            return
