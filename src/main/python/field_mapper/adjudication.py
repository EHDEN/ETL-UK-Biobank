from src.main.python.core.database import Database
from src.main.python.core.model.vocabularies import Concept
from src.main.python.field_mapper.FieldConceptMapper import FieldConceptMapper
from pathlib import Path
import csv
import yaml

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


# mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping/'), 'ERROR')
# mapper._load_usagi(Path('./resources/baseline_field_mapping/usagi_numeric_prio_fields.csv'))


def create_adjudication_row(mapping):
    row = {
        'field_id':mapping.field_id,
        'field_url':"https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=" + mapping.field_id,
        'field_name':mapping.field_description,
        'value':mapping.value_code,
        'value_code':mapping.value_description,
        'target_concept_id':None,
        'value_concept_id':None,
        'unit_concept_id':None,
        'comment':mapping.comment,
        'source':mapping.source_file_name
    }
    if mapping.event_target:
        row['target_concept_id'] = get_concept(mapping.event_target.concept_id)
    if mapping.unit_target:
        row['unit_concept_id'] = get_concept(mapping.unit_target.concept_id)
    if mapping.value_target:
        row['value_concept_id'] = get_concept(mapping.value_target.concept_id)
    return row

for usagi_path in Path('./resources/baseline_field_mapping/').glob('*.csv'):
    mapper = FieldConceptMapper(None, 'ERROR')
    mapper._load_usagi(usagi_path)

    with open(f'./src/main/python/field_mapper/adjudication/adjudication_{usagi_path.name[:-4]}.csv', 'w') as f_out:
        csv_out = csv.DictWriter(f_out, ['field_id','field_url','field_name','value','value_code','target_concept_id','value_concept_id','unit_concept_id','comment','source'])
        csv_out.writeheader()
        for mapping in mapper.get_random(50):
            if mapping.has_values():
                for value_mapping in mapping.get_values():
                    csv_out.writerow(create_adjudication_row(value_mapping))
            else:
                csv_out.writerow(create_adjudication_row(mapping))


# TODO: list all flagged fields