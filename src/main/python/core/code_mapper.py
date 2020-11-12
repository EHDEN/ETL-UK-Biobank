# Copyright 2020 The Hyve
#
# Licensed under the GNU General Public License, version 3,
# or (at your option) any later version (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

from __future__ import annotations
import pandas as pd
from sqlalchemy import and_
from sqlalchemy.orm import aliased
from typing import Optional, Union, List, Dict
import logging


logger = logging.getLogger(__name__)


class CodeMapping:

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
    def create_mapping_for_no_match(cls, source_concept_code) -> CodeMapping:
        mapping = cls()
        mapping.source_concept_code = source_concept_code
        mapping.source_concept_id = 0
        mapping.target_concept_id = 0
        return mapping

    def __str__(self):
        # note: omitting standard concept and invalid reason
        return f'{self.source_concept_code} ' \
               f'({self.source_vocabulary_id}) ' \
               f'"{self.source_concept_name}" => ' \
               f'concept_id: {self.target_concept_id}, ' \
               f'concept_code: {self.target_concept_code}, ' \
               f'concept_name: "{self.target_concept_name}", ' \
               f'vocabulary_id: {self.target_vocabulary_id}'


class MappingDict:

    def __init__(self):
        self.mapping_dict: Dict[str, List[CodeMapping]] = {}

    @classmethod
    def from_mapping_df(cls, mapping_df: pd.DataFrame) -> MappingDict:

        mapping_dict_from_df = cls()
        mapping_dict = {}

        for _, row in mapping_df.iterrows():
            code = row['source.concept_code']
            target_concept_id = 0 if pd.isnull(row['target.concept_id']) \
                else row['target.concept_id']
            mapping = CodeMapping()
            mapping.source_concept_code = code
            mapping.source_concept_id = row['source.concept_id']
            mapping.source_concept_name = row['source.concept_name']
            mapping.source_vocabulary_id = row['source.vocabulary_id']
            mapping.source_standard_concept = row['source.standard_concept']
            mapping.source_invalid_reason = row['source.invalid_reason']
            mapping.target_concept_code = row['target.concept_code']
            mapping.target_concept_id = target_concept_id
            mapping.target_concept_name = row['target.concept_name']
            mapping.target_vocabulary_id = row['target.vocabulary_id']

            mapping_dict[code] = mapping_dict.get(code, []) + [mapping]

        mapping_dict_from_df.mapping_dict = mapping_dict

        return mapping_dict_from_df

    def remove_dot_from_code(self) -> None:
        """
        Mainly for ICD9 and ICD10 codes that are recorded in the source without a dot.
        :return:
        """
        new_mapping_dict = {}
        for key in self.mapping_dict:
            value = self.mapping_dict.get(key)
            key_no_dot = key.replace('.', '')
            new_mapping_dict[key_no_dot] = value
        self.mapping_dict = new_mapping_dict

    def lookup(self, code: str,
               first_only: bool = False,
               full_mapping: bool = False) \
            -> Union[List[str], List[CodeMapping], str, CodeMapping]:

        """
        Given a valid vocabulary code, retrieves a list of all corresponding
        standard concept_ids from the stored mapping dictionary.
        Optionally, you can restrict the results to the first
        available match. For reviewing purposes, you can also opt to
        retrieve the full mapping information as a CodeMapping object.

        Match for source and standard: list of one or more CodeMappings
        Match for source (no standard): list of one CodeMapping, target_concept_id = 0
        No Match (code not found): list of one CodeMapping, source_concept_id = 0, target_concept_id = 0

        :param vocabulary_code: string representing the code to lookup
        :param first_only: if True, return the first available match
        only (default False)
        :param full_mapping: if True, return the full mapping
        information as a CodeMapping object (default False)
        :return: a single match or list of matches, either standard
        concept_ids (string) or CodeMapping objects
        """

        if not self.mapping_dict:
            logger.warning('Trying to retrieve a mapping from an empty dictionary!')

        mappings = self.mapping_dict.get(code, [])  # full CodeMapping object
        if not mappings:
            logger.debug(f'No mapping available for {code}')
            mappings = [CodeMapping.create_mapping_for_no_match(code)]

        if not full_mapping:
            mappings = [mapping.target_concept_id for mapping in mappings]  # standard concept_id only

        if first_only:
            if len(mappings) > 1:
                logger.debug(f'Multiple mappings available for {code}, '
                             f'returning only first.')
            return mappings[0]

        return mappings


class CodeMapper:

    def __init__(self, database, cdm):

        self.db = database
        self.cdm = cdm

    def generate_code_mapping_dictionary(self,
                                         vocabulary_id: Union[str, List[str]],
                                         restrict_to_codes: Optional[List[str]] = None,
                                         invalid_reason: Optional[Union[str, List[str]]] = None,
                                         standard_concept: Optional[Union[str, List[Union[str, int]]]] = None,
                                         remove_dot: bool = False) \
            -> MappingDict:

        """
        Given one or more non-standard vocabulary names (e.g. Read, ICD10),
        creates a dictionary of mappings from the non-standard vocabulary codes
        to standard OMOP concept_ids (typically SNOMED);
        the results can be restricted to a specific list of vocabulary codes to save memory.

        Source (non-standard) code matches can be filtered
        by invalid_reason and standard_concept values;
        target (standard) concept_ids are always standard and valid.

        Note that multiple mappings from non-standard codes
        to standard concept_ids are possible.

        Returns a dictionary with the results of the mapping.

        :param vocabulary_id: valid OMOP vocabulary_id(s) (list or string)
        :param restrict_to_codes: (optional) subset of vocabulary codes
        to retrieve mappings for(list)
        :param invalid_reason: (optional) any of 'U', 'D', 'R', 'NONE' (list or string)
        :param standard_concept: (optional) any of 'S', 'C', 'NONE' (list or string)
        :param remove_dot: for e.g. icd9 and icd10 the source codes do not contain the dot separator
        :return: MappingDict
        """

        logger.info(f'Building mapping dictionary for vocabularies: {vocabulary_id}')

        source = aliased(self.cdm.Concept)
        target = aliased(self.cdm.Concept)

        source_filters = []

        # vocabulary: either str or list
        if type(vocabulary_id) == list:
            source_filters.append(source.vocabulary_id.in_(vocabulary_id))
        elif type(vocabulary_id) == str:
            source_filters.append(source.vocabulary_id == vocabulary_id)
        # invalid reason: either list, str (incl. NULL), or None (in which case filter is not applied)
        if type(invalid_reason) == list:
            source_filters.append(source.invalid_reason.in_(invalid_reason))
        elif invalid_reason == 'NULL':
            source_filters.append(source.invalid_reason == None)
        elif type(invalid_reason) == str:
            source_filters.append(source.invalid_reason == invalid_reason)
        # standard concept: either list, str (incl. NULL), or None (in which case filter is not applied)
        if type(standard_concept) == list:
            source_filters.append(source.standard_concept.in_(standard_concept))
        elif standard_concept == 'NULL':
            source_filters.append(source.standard_concept == None)
        elif type(standard_concept) == str:
            source_filters.append(source.standard_concept == standard_concept)

        if restrict_to_codes:
            source_filters.append(source.concept_code.in_(restrict_to_codes))

        with self.db.session_scope() as session:
            records = session.query(
                source.concept_code.label('source.concept_code'),
                source.concept_id.label('source.concept_id'),
                source.concept_name.label('source.concept_name'),
                source.vocabulary_id.label('source.vocabulary_id'),
                source.standard_concept.label('source.standard_concept'),
                source.invalid_reason.label('source.invalid_reason'),
                target.concept_code.label('target.concept_code'),
                target.concept_id.label('target.concept_id'),
                target.concept_name.label('target.concept_name'),
                target.vocabulary_id.label('target.vocabulary_id')) \
                .outerjoin(self.cdm.ConceptRelationship,
                           and_(source.concept_id == self.cdm.ConceptRelationship.concept_id_1,
                                self.cdm.ConceptRelationship.relationship_id == 'Maps to')) \
                .outerjoin(target,
                           and_(self.cdm.ConceptRelationship.concept_id_2 == target.concept_id,
                                target.standard_concept == 'S',
                                target.invalid_reason == None)) \
                .filter(and_(*source_filters)) \
                .all()

        mapping_df = pd.DataFrame(records)
        mapping_dict = MappingDict.from_mapping_df(mapping_df)

        if remove_dot:
            mapping_dict.remove_dot_from_code()

        if not mapping_dict.mapping_dict:
            logger.warning(f'No mapping found, mapping dictionary empty')

        if restrict_to_codes:
            not_found = set(restrict_to_codes) - set(mapping_dict.mapping_dict.keys())
            if not_found:
                logger.warning(f'No mapping to standard concept_id could be generated for '
                               f'{len(not_found)}/{len(restrict_to_codes)} codes:'
                               f' {not_found}')
        return mapping_dict
