from src.main.python.core.database import Database
from src.main.python.core.model.vocabularies import Concept
from src.main.python.field_mapper.FieldConceptMapper import FieldConceptMapper
from pathlib import Path
import csv
import random
import yaml

from src.main.python.field_mapper.model.UsagiModel import MappingStatus

with open('./config/config-local.yml') as f_config:
    config = yaml.full_load(f_config)
    db = Database.from_config(config)
    session = db.get_new_session()


def get_concept(concept_id):
    try:
        c = session.query(Concept).get(concept_id)
        return '|'.join(map(str, [c.concept_id, c.concept_name, c.vocabulary_id, c.domain_id, c.concept_class_id, c.standard_concept]))
    except:
        return '|'.join([str(concept_id), '?'])


def create_adjudication_row(mapping):
    row = {
        'status': mapping.status.name,
        'field_id': mapping.field_id,
        'field_url': "https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=" + mapping.field_id,
        'field_name': mapping.field_description,
        'value': mapping.value_code,
        'value_code': mapping.value_description,
        'target_concept': None,
        'value_concept': None,
        'unit_concept': None,
        'comment': mapping.comment,
        'source': mapping.source_file_name
    }
    if mapping.event_target:
        row['target_concept'] = get_concept(mapping.event_target.concept_id)
    if mapping.unit_target:
        row['unit_concept'] = get_concept(mapping.unit_target.concept_id)
    if mapping.value_target:
        row['value_concept'] = get_concept(mapping.value_target.concept_id)
    return row


def write_mapping(csv_out, mapping):
    if mapping.has_values():
        for value_mapping in mapping.get_values():
            csv_out.writerow(create_adjudication_row(value_mapping))
    else:
        csv_out.writerow(create_adjudication_row(mapping))


for usagi_path in Path('./resources/baseline_field_mapping/').glob('*.csv'):
    mapper = FieldConceptMapper(None, 'ERROR')
    # Load just one file
    mapper.load_usagi(usagi_path)

    with open(f'./src/main/python/field_mapper/adjudication/adjudication_{usagi_path.name[:-4]}.csv', 'w') as f_out:
        csv_out = csv.DictWriter(f_out,
                                 ['status', 'field_id', 'field_url', 'field_name', 'value', 'value_code', 'target_concept', 'value_concept',
                                  'unit_concept', 'comment', 'source'])
        csv_out.writeheader()

        # TODO: opcs fields (three field_ids)

        if len(mapper.field_mappings) == 1:
            # Files with just mappings of one field_id are rather mapped on value
            field_id, field_mapping = mapper.field_mappings.popitem()
            for value_mapping in field_mapping.get_values():
                if value_mapping.is_flagged():
                    csv_out.writerow(create_adjudication_row(value_mapping))
                elif random.random() < 0.1:
                    csv_out.writerow(create_adjudication_row(value_mapping))
                else:
                    # do not include for adjudication
                    pass
            mappings = mapper.field_mappings.values()
        else:
            for mapping in mapper.field_mappings.values():
                if mapping.is_flagged() or mapping.has_flagged_values():
                    write_mapping(csv_out, mapping)
                elif random.random() < 0.1:
                    write_mapping(csv_out, mapping)
                else:
                    # do not include for adjudication
                    pass
