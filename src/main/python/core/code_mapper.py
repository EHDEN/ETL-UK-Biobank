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


class CodeMapper:

    def __init__(self, database, cdm):

        self.db = database
        self.cdm = cdm
        self.mapping_dict = {}


    def nonstandard_to_standard_code_dict(self,
                                          source_code_list: list,
                                          vocabulary_id: Optional[Union[str, list]] = None,
                                          invalid_reason: Optional[Union[str, list]] = None,
                                          standard_concept: Optional[Union[str, list]] = None) \
            -> Dict:

        """
        Given a non-standard list of ontology codes and the vocabularies to look into,
        retrieves the corresponding standard OMOP concept_id (typically SNOMED).

        You can filter source code matches by invalid_reason and standard_concept;
        target concept_ids are always standard and valid.

        Note that multiple mappings from non-standard to standard concepts could exist.

        Returns a dictionary with the results of the mapping.
        """

        mapping_df = self.map_vocabulary_codes_to_standard_concept_ids(
            vocabulary_id, source_code_list, invalid_reason, standard_concept)

        mapping_dict = mapping_df.set_index('source.concept_code').to_dict()['target.concept_id']

        return mapping_dict

    def map_vocabulary_codes_to_standard_concept_ids(self,
                                    vocabulary_id: Union[str, List[str]],
                                    restrict_to_codes: Optional[List[str]] = None,
                                    invalid_reason: Optional[Union[str, List[str]]] = None,
                                    standard_concept: Optional[Union[str, List[Union[str, int]]]] = None) \
            -> pd.DataFrame:

        '''
        Given an OMOP vocabulary name composed of non-standard codes,
        retrieves the mappings to standard OMOP concept_id (typically SNOMED);
        the results can be restricted to a specific list of non-standard codes to save memory.

        Source (non-standard) code matches can be filterd by invalid_reason and standard_concept values;
        target (standard) concept_ids are always standard and valid.

        Note that multiple mappings from non-standard codes to standard concept_ids are possible.
        '''

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

        records_df = pd.DataFrame(records)

        if restrict_to_codes:
            records_df.query('`source.concept_code` in @restrict_to_codes', inplace=True)

        return records_df
