"""Code mapping."""

from __future__ import annotations

import logging
from typing import Optional, Union, List, Set, Dict, NamedTuple

from sqlalchemy import and_
from sqlalchemy.orm import aliased

from ...util.helper import is_null_or_falsy

logger = logging.getLogger(__name__)


class Record(NamedTuple):
    """Type checking proxy for SQLAlchemy query results."""

    source_concept_code: str
    source_concept_id: int
    source_concept_name: str
    source_invalid_reason: str
    source_standard_concept: str
    source_vocabulary_id: str
    target_concept_code: str
    target_concept_id: int
    target_concept_name: str
    target_vocabulary_id: str


class CodeMapping:
    """
    A single source to target mapping.

    All attributes are set to None upon instantiation.

    Attributes
    ----------
    source_concept_code : str
        Original source code used in the lookup.
    source_concept_id : int
        Source code OMOP concept_id.
    source_concept_name : str
        Source code description.
    source_vocabulary_id : str
        OMOP identifier for the source code ontology.
    source_standard_concept : str
        One of None, 'S', or 'C' (typically None)
    source_invalid_reason : str
        One of None, 'D', or 'U' (typically None)
    target_concept_code : str
        Mapped ontology code.
    target_concept_id : int
        Mapped OMOP concept_id;
        if available, it's always valid and standard.
    target_concept_name : str
        Mapped code description.
    target_vocabulary_id : str
        OMOP identifier for the mapped code ontology.
    """

    def __init__(self):
        self.source_concept_code = None
        self.source_concept_id = None
        self.source_concept_name = None
        self.source_vocabulary_id = None
        self.source_standard_concept = None
        self.source_invalid_reason = None
        self.target_concept_code = None
        self.target_concept_id = None
        self.target_concept_name = None
        self.target_vocabulary_id = None

    @classmethod
    def create_mapping_for_no_match(cls, source_code) -> CodeMapping:
        """
        Return CodeMapping instance specifying no mapping is available.

        Parameters
        ----------
        source_code : str

        Returns
        -------
        CodeMapping
        """
        mapping = cls()
        mapping.source_concept_code = source_code
        mapping.source_concept_id = 0
        mapping.target_concept_id = 0
        return mapping


class MappingDict:
    """
    Container of one or multiple source code to target mappings.

    Attributes
    ----------
    mapping_dict : dict
        Source code to target dictionary.
    """

    def __init__(self):
        self.mapping_dict: Dict[str, List[CodeMapping]] = {}

    @classmethod
    def from_records(cls, records: List[Record]) -> MappingDict:
        """
        Create MappingDict from a query result list.

        Query result list needs to originate from a SQLAlchemy query
        compliant with the required Record format. The method also works
        on a list of named tuples, as long as they have the required
        Record fields.

        Parameters
        ----------
        records : list of Record objects
            A list of named tuples compliant with the Record format,
            e.g. as the result of a SQLAlchemy query.

        Returns
        -------
        MappingDict
        """
        mapping_dict_from_records = cls()
        mapping_dict = {}

        for record in records:
            code = record.source_concept_code
            target_concept_id = record.target_concept_id if record.target_concept_id else 0
            mapping = CodeMapping()
            mapping.source_concept_code = code
            mapping.source_concept_id = record.source_concept_id
            mapping.source_concept_name = record.source_concept_name
            mapping.source_vocabulary_id = record.source_vocabulary_id
            mapping.source_standard_concept = record.source_standard_concept
            mapping.source_invalid_reason = record.source_invalid_reason
            mapping.target_concept_code = record.target_concept_code
            mapping.target_concept_id = target_concept_id
            mapping.target_concept_name = record.target_concept_name
            mapping.target_vocabulary_id = record.target_vocabulary_id

            mapping_dict[code] = mapping_dict.get(code, []) + [mapping]

        mapping_dict_from_records.mapping_dict = mapping_dict

        return mapping_dict_from_records

    def lookup(self,
               source_code: str,
               first_only: bool = False,
               target_concept_id_only: bool = False,
               ) -> Union[List[int], List[CodeMapping], int, CodeMapping]:
        """
        Retrieve mapping list for a given source code.

        Given a source concept_code, retrieves a list of mappings to
        standard_concept_id from the stored mapping dictionary.

        Optionally, you can restrict the results to the first
        available match only, and/or to target concept_id only
        (instead of full CodeMapping objects).
        If both source code and target concept_id found: returns one or
        more mappings;
        if only source code is found: returns a single mapping with
        target_concept_id = 0;
        if source code is not found: returns a single mapping with
        source_concept_id = 0 and target_concept_id = 0.

        Parameters
        ----------
        source_code : str
            The source code to lookup.
        first_only : bool, default False
            If True, return the first available match only.
        target_concept_id_only : bool, default False
            If True, return the target_concept_id only (as string).

        Returns
        -------
        mapping
            A single match or list of matches, either standard
            concept_ids (integer) or CodeMapping objects.
        """
        # full CodeMapping object
        mappings = self.mapping_dict.get(source_code, [])

        if not self.mapping_dict:
            logger.warning('Trying to retrieve mappings from an empty dictionary!')

        if not mappings:
            logger.debug(f'No mapping available for {source_code}, mapping to concept_id == 0')
            mappings = [CodeMapping.create_mapping_for_no_match(source_code)]
        elif len(mappings) == 1 and mappings[0].target_concept_id == 0:
            logger.debug(f'Only mapping available for {source_code} is to concept_id == 0')

        if target_concept_id_only:
            mappings = [mapping.target_concept_id for mapping in mappings]

        if first_only:
            if len(mappings) > 1:
                logger.debug(f'Multiple mappings available for {source_code}, '
                             f'returning only first.')
            return mappings[0]

        return mappings


class CodeMapper:
    """Creator of code mappings."""

    def __init__(self, database, cdm):
        self.db = database
        self.cdm = cdm

    def generate_code_mapping_dictionary(
            self,
            vocabulary_id: Union[str, List[str]],
            restrict_to_codes: Optional[Union[List[str], Set[str]]] = None,
            invalid_reason: Optional[Union[str, List[str]]] = None,
            standard_concept: Optional[Union[str, List[str]]] = None
    ) -> MappingDict:
        """
        Create a dictionary of code mappings.

        Mappings from non-standard concept_codes to standard
        concept_ids will be generated from the vocabulary table
        concept_relationship by extracting valid "Maps_to" type
        relationships.

        Accepts one or more source OMOP vocabulary names (e.g.
        Read, ICD10); the lookup can be restricted to a specific list of
        source concept_codes within the specified vocabularies to save
        memory.

        Source concept_codes can be additionally filtered by
        invalid_reason and standard_concept values; target (standard)
        concept_ids are always standard and valid.
        Note that multiple mappings from non-standard codes to standard
        concept_id are possible.

        Returns a dictionary with source concept_codes as keys, and
        mappings (in the form of CodeMapping objects) as values.

        Parameters
        ----------
        vocabulary_id : str or list of str
            Valid non-standard OMOP vocabulary_id(s).
        restrict_to_codes : list of str, optional
            Subset of vocabulary codes to retrieve mappings for.
        invalid_reason : str or list of str, optional
            Any of 'U', 'D', 'R', 'NULL'.
        standard_concept : str or list of str, optional
            Any of 'S', 'C', 'NULL'.

        Returns
        -------
        MappingDict
        """
        if restrict_to_codes:
            # remove redundant codes
            restrict_to_codes = list(set(restrict_to_codes))
            # remove invalid codes
            restrict_to_codes = [code for code in restrict_to_codes if not is_null_or_falsy(code)]

        logger.info(f'Building mapping dictionary for vocabularies: {vocabulary_id}')

        source = aliased(self.cdm.Concept)
        target = aliased(self.cdm.Concept)

        source_filters = []

        # vocabulary: either str or list
        if type(vocabulary_id) == list:
            source_filters.append(source.vocabulary_id.in_(vocabulary_id))
        elif type(vocabulary_id) == str:
            source_filters.append(source.vocabulary_id == vocabulary_id)
        # invalid reason: either list, str (incl. "NULL"),
        # or None (filter is not applied)
        if type(invalid_reason) == list:
            source_filters.append(source.invalid_reason.in_(invalid_reason))
        elif invalid_reason == 'NULL':
            source_filters.append(source.invalid_reason.is_(None))
        elif type(invalid_reason) == str:
            source_filters.append(source.invalid_reason == invalid_reason)
        # standard concept: either list, str (incl. "NULL"),
        # or None (filter is not applied)
        if type(standard_concept) == list:
            source_filters.append(source.standard_concept.in_(standard_concept))
        elif standard_concept == 'NULL':
            source_filters.append(source.standard_concept.is_(None))
        elif type(standard_concept) == str:
            source_filters.append(source.standard_concept == standard_concept)
        if restrict_to_codes:
            source_filters.append(source.concept_code.in_(restrict_to_codes))

        with self.db.session_scope() as session:
            records = session.query(
                source.concept_code.label('source_concept_code'),
                source.concept_id.label('source_concept_id'),
                source.concept_name.label('source_concept_name'),
                source.vocabulary_id.label('source_vocabulary_id'),
                source.standard_concept.label('source_standard_concept'),
                source.invalid_reason.label('source_invalid_reason'),
                target.concept_code.label('target_concept_code'),
                target.concept_id.label('target_concept_id'),
                target.concept_name.label('target_concept_name'),
                target.vocabulary_id.label('target_vocabulary_id')) \
                .outerjoin(self.cdm.ConceptRelationship,
                           and_(source.concept_id == self.cdm.ConceptRelationship.concept_id_1,
                                self.cdm.ConceptRelationship.relationship_id == 'Maps to',
                                self.cdm.ConceptRelationship.invalid_reason.is_(None))) \
                .outerjoin(target,
                           and_(self.cdm.ConceptRelationship.concept_id_2 == target.concept_id,
                                target.standard_concept == 'S',
                                target.invalid_reason.is_(None))) \
                .filter(and_(*source_filters)) \
                .distinct() \
                .all()

        mapping_dict = MappingDict.from_records(records)

        if not mapping_dict.mapping_dict:
            logger.warning('No mapping found, mapping dictionary empty!')
        if restrict_to_codes:
            not_found = set(restrict_to_codes) - mapping_dict.mapping_dict.keys()
            found_without_mapping = {code for code in mapping_dict.mapping_dict.keys() if
                                     mapping_dict.mapping_dict[code][0].target_concept_id == 0}
            if not_found:
                logger.warning(f'{len(not_found)}/{len(restrict_to_codes)} codes were not found '
                               f'in vocabularies (excluded from mapping dict): '
                               f'{not_found}')
            if found_without_mapping:
                logger.warning(f'{len(found_without_mapping)}/{len(restrict_to_codes)} codes '
                               f'have no mapping to valid standard concept_id (mapped to 0): '
                               f'{found_without_mapping}')
        return mapping_dict
