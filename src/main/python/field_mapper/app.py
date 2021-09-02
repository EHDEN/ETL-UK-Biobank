# -*- coding: utf-8 -*-

# Run this app with `python app.py` and
# visit http://127.0.0.1:8050/ in your web browser.
import json

import dash
import dash_table
import requests
from dash.dependencies import Input, Output
import dash_html_components as html

from pathlib import Path

from src.main.python.field_mapper.FieldConceptMapper import FieldConceptMapper

UKB_FIELD_ID_URL = "https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=%s"
ATHENA_CONCEPT_ID_URL = "https://athena.ohdsi.org/search-terms/terms/%s"

mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'ERROR')
# mapper = FieldConceptMapper(None, 'ERROR')
# mapper.load_usagi_file(Path('./resources/baseline_field_mapping/numeric_prio_fields.csv'))

# TODO: Add additional column for target domain.
# TODO: Use note instead of comment?
i = 0
data = []
for mapping in mapper.get_all_mappings():
    values = ""
    if mapping.has_values():
        map_type = '⭕️categorical'
        values = ','.join([x for x in mapping.values])
    elif mapping.has_unit():
        if mapping.is_flagged():
            map_type = '📋 unmapped'
        else:
            map_type = '🔢 numeric/🔠 text'
    elif mapping.is_ignored():
        map_type = '❌ ignored'
    else:
        map_type = '📋 unmapped'

    data.append({
        'source_file': mapping.source_file_name,
        'field_id': mapping.field_id,
        'field_description': mapping.field_description,
        'approach': map_type,
        'value_codes': values
    })

app = dash.Dash(__name__)

app.layout = html.Div(children=[
    html.H1(children='FieldConceptMapper'),

    dash_table.DataTable(
        id='field-table',
        data=data,
        columns=[{"name": i, "id": i} for i in data[0]],
        style_data={
            'whiteSpace': 'normal',
            'height': 'auto',
            'padding-left': '5px',
            'padding-right': '5px'
        },
        style_cell={
            'textAlign': 'left',
            'overflow': 'hidden',
            'textOverflow': 'ellipsis'
        },
        style_cell_conditional=[
            {'if': {'column_id': 'field_id'},
             'width': '120px',
             'textAlign': 'right'},
            {'if': {'column_id': 'mapping_approach'},
             'width': '80px'},
        ],
        row_selectable='single',
        sort_action='native',
        filter_action='native',
        page_action='native',
        page_current=0,
        page_size=10
    ),

    html.Div(id='field-detail-container'),

    html.Div(
        html.P("© The Hyve 2020 (thehyve.nl) - European Health Data & Evidence Network (ehden.eu) - Innovative Medicines Initiative (imi.europa.eu/)")
    )
])


@app.callback(
    Output('field-detail-container', "children"),
    [Input('field-table', "derived_virtual_data"),
     Input('field-table', "derived_virtual_selected_rows")])
def update_field_detail(rows, derived_virtual_selected_rows):
    if not derived_virtual_selected_rows:
        return []

    selected_row = rows[derived_virtual_selected_rows[0]]
    field_mapping = mapper.get_mapping(str(selected_row['field_id']))
    event_targets = ','.join(map(str, field_mapping.event_targets))
    event_concept = field_mapping.get_event_concept_id()

    omop_information = omop_info(event_concept)
    unit_information = omop_info(field_mapping.get_unit_concept_id())

    if event_concept == 0:
        event_information = [html.Td(html.B("Event: "))]
    else:
        event_information = [html.Td(html.B("Event: ")), html.Td(event_targets + ','), html.Td('Domain: ' + omop_information['domain'] + ','),
            html.Td('Vocab: ' + omop_information['vocab'])]

    return [
        html.H3(html.A(
            f'UK-Biobank: {field_mapping.field_id} - {field_mapping.field_description}',
            href=UKB_FIELD_ID_URL % field_mapping.field_id,
            target="_blank"
        )),

        html.H3(html.A(
            f'Athena: {event_concept} - {omop_information["name"]}',
            href=ATHENA_CONCEPT_ID_URL % event_concept,
            target="_blank"
        )),

        html.P(selected_row['approach']),
        html.Table([
                html.Tr(event_information)
                ,
                html.Tr(
                    [html.Td(html.B("Unit: ")), html.Td(str(field_mapping.unit_target) + ',')])
                ,
                html.Tr(
                    [html.Td(html.B("Comment")), html.Td(field_mapping.comment)])
            ]
        ),
        # TODO: include list of value mappings.
        html.Code(str(field_mapping))
    ]


def omop_info(concept_id):
    response = requests.get(f'https://athena.ohdsi.org/api/v1/concepts/{concept_id}')
    concept = json.loads(response.text)
    info = {'name': concept['name'], 'vocab': concept['vocabularyId'], 'domain': concept['domainId']}
    return info


if __name__ == '__main__':
    app.run_server(debug=True)
