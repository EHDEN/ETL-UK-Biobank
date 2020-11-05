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
from typing import Optional, Union, Tuple
import logging
import src.main.python.core.model as cdm


logger = logging.getLogger(__name__)


class ConceptMapper:

    def __init__(self, database):

        self.db = database
        self.cdm = cdm

    def nonstandard_to_standard_code_dict(self,
                                          source_code_list: list,
                                          vocabulary_id: Optional[Union[str, list]] = None,
                                          invalid_reason: Optional[Union[str, list]] = None,
                                          standard_concept: Optional[Union[str, list]] = None) \
            -> dict:

        """
        Given a non-standard list of ontology codes and the vocabularies to look into,
        retrieves the corresponding standard OMOP concept_id (typically SNOMED).

        You can filter source code matches by invalid_reason and standard_concept;
        target concept_ids are always standard and valid.

        Note that multiple mappings from non-standard to standard concepts could exist.

        Returns a dictionary with the results of the mapping.
        """

        mapping_df = self.nonstandard_to_standard_code_df(
            source_code_list, vocabulary_id, invalid_reason, standard_concept)

        mapping_dict = mapping_df.set_index('source.concept_code').to_dict()['target.concept_id']

        return mapping_dict

    def nonstandard_to_standard_code_df(self,
                                        source_code_list: list,
                                        vocabulary_id: Optional[Union[str, list]] = None,
                                        invalid_reason: Optional[Union[str, list]] = None,
                                        standard_concept: Optional[Union[str, list]] = None) \
            -> pd.DataFrame:
        """
        Given a non-standard list of ontology codes and the vocabularies to look into,
        retrieves the corresponding standard OMOP concept_id (typically SNOMED),
        plus additional information about both source and target codes.

        You can filter source code matches by invalid_reason and standard_concept;
        target concept_ids are always standard and valid.

        Note that multiple mappings from non-standard to standard concepts could exist.

        Returns a dataframe with the results of the mapping.
        """

        source = aliased(self.cdm.Concept)
        target = aliased(self.cdm.Concept)

        source_filters = []

        if type(vocabulary_id) == list:
            source_filters.append(source.vocabulary_id.in_(vocabulary_id))
        else:
            source_filters.append(source.vocabulary_id == vocabulary_id)

        if type(invalid_reason) == list:
            source_filters.append(source.invalid_reason.in_(invalid_reason))
        else:
            source_filters.append(source.invalid_reason == invalid_reason)

        if type(standard_concept) == list:
            source_filters.append(source.standard_concept.in_(standard_concept))
        else:
            source_filters.append(source.standard_concept == standard_concept)

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
                .join(self.cdm.ConceptRelationship,
                      source.concept_id == cdm.ConceptRelationship.concept_id_1) \
                .join(target,
                      target.concept_id == cdm.ConceptRelationship.concept_id_2) \
                .filter(and_(*source_filters)) \
                .filter(
                cdm.ConceptRelationship.relationship_id == 'Maps to',
                # note: the following shouldn't be necessary given the nature of the "Maps to" relationship
                target.standard_concept == 'S',
                target.invalid_reason == None,
                # the most expensive filter is applied last
                source.concept_code.in_(source_code_list)) \
                .all()

        records_df = pd.DataFrame(records)

        return records_df
