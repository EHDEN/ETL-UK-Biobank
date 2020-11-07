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

import pandas as pd
from sqlalchemy import and_
from sqlalchemy.orm import aliased
from typing import Optional, Union, List, Dict
import logging


logger = logging.getLogger(__name__)


class CodeMapping:

    def __init__(self):
        self.concept_id = None
        self.value_as_concept_id = None
        self.value_as_number = None
        self.unit_concept_id = None
        self.source_value = None
        self.value_source_value = None

        self.variable_comment = None
        self.value_comment = None

    def __str__(self):
        return f'{self.source_value}-{self.value_source_value} => ' \
               f'concept_id: {self.concept_id}, ' \
               f'value_as_concept_id: {self.value_as_concept_id}, ' \
               f'value_as_number: {self.value_as_number}, ' \
               f'unit_concept_id: {self.unit_concept_id}, ' \
               f'source_value: {self.source_value}, ' \
               f'value_source_value: {self.value_source_value}, ' \
               f'variable_comment: {self.variable_comment}, ' \
               f'value_comment: {self.value_comment}'

class MappingDict:

    def __init__(self, mapping_df):
        self.mapping_dict = self.from_mapping_df(mapping_df)

    def from_mapping_df(self, mapping_df: pd.DataFrame) -> Dict[str, List[CodeMapping]]:

        mapping_dict = {}

        for _, row in mapping_df.iterrows():
            code = row['source.concept_code']
            mapping = CodeMapping()
            # TODO
            mapping_dict[code] = mapping_dict.get(code, []).append(mapping)

        return mapping_dict

    def lookup(self, vocabulary_code: str,
               first_only: bool = False,
               full_mapping: bool = False) \
            -> Union[List[str], List[CodeMapping], str, CodeMapping]:

        """
        Given a vocabulary code, retrieves a list of all corresponding
        standard concept_ids from the stored mapping dictionary.
        Optionally, you can restrict the results to the first
        available match. For reviewing purposes, you can also opt to
        retrieve the full mapping information as a CodeMapping object.

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

        if full_mapping:
            hits = self.mapping_dict.get(vocabulary_code, []) # full CodeMapping object
        else:
            hits=[]
            for mapping in self.mapping_dict.get(vocabulary_code, []):
                hits.append(mapping.concept_id) # standard concept_id only

        if hits and first_only:
            if len(hits)>1:
                logger.warning(f'Multiple mappings found for {vocabulary_code}, returning only '
                               f'first.')
            return hits[0]

        return hits


class CodeMapper:

    def __init__(self, database, cdm):

        self.db = database
        self.cdm = cdm

    def generate_code_mapping_dictionary(self,
                                         vocabulary_id: Union[str, List[str]],
                                         restrict_to_codes: Optional[List[str]] = None,
                                         invalid_reason: Optional[Union[str, List[str]]] = None,
                                         standard_concept: Optional[Union[str, List[Union[str, int]]]] = None) \
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
        :return: MappingDict
        """

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

        target_filters = [
            self.cdm.ConceptRelationship.relationship_id == 'Maps to',
            # the following shouldn't really be necessary given the nature of the "Maps to"
            # relationships, but it doesn't hurt to be sure..
            target.standard_concept == 'S',
            target.invalid_reason == None
        ]

        records = self.db.session.query(
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
            .join(self.cdm.ConceptRelationship,
                  source.concept_id == self.cdm.ConceptRelationship.concept_id_1) \
            .join(target,
                  target.concept_id == self.cdm.ConceptRelationship.concept_id_2) \
            .filter(and_(*source_filters)) \
            .filter(and_(*target_filters)) \
            .all()

        mapping_df = pd.DataFrame(records)

        if restrict_to_codes:
            mapping_df.query('`source.concept_code` in @restrict_to_codes', inplace=True)

        mapping_dict = MappingDict(mapping_df)

        return mapping_dict
