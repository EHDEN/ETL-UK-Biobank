# -*- coding: utf-8 -*-

# Run this app with `python app.py` and
# visit http://127.0.0.1:8050/ in your web browser.

import dash
import dash_table
from dash.dependencies import Input, Output
import dash_html_components as html

from pathlib import Path

from src.main.python.field_mapper.FieldConceptMapper import FieldConceptMapper

UKB_FIELD_ID_URL = "https://biobank.ctsu.ox.ac.uk/crystal/field.cgi?id=%s"
ATHENA_CONCEPT_ID_URL = "https://athena.ohdsi.org/search-terms/terms/%s"

# mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'ERROR')
mapper = FieldConceptMapper(None, 'ERROR')
mapper.load_usagi_file(Path('./resources/baseline_field_mapping/numeric_prio_fields.csv'))

i = 0
data = []
for mapping in mapper.get_random_mappings(50):
    values = ""
    if mapping.has_values():
        map_type = '⭕️categorical'
        values = ','.join([x for x in mapping.values])
    elif mapping.has_unit():
        map_type = '🔢numeric'
    elif mapping.is_ignored():
        map_type = '❌ignored'
    else:
        map_type = 'unmapped'  # TODO

    data.append({
        'source_file': mapping.source_file_name,
        'field_id': int(mapping.field_id),
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
            'height': 'auto'
        },
        style_cell_conditional=[
            {'if': {'column_id': 'field_id'},
             'width': '80px'},
            {'if': {'column_id': 'mapping_approach'},
             'width': '80px'},
        ],
        style_cell={
            'textAlign': 'left',
            'overflow': 'hidden',
            'textOverflow': 'ellipsis'
        },
        row_selectable='single',
        sort_action='native',
        filter_action='native',
        page_action='native',
        page_current= 0,
        page_size= 10
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

    return [
        html.H2(html.A(
            f'{field_mapping.field_id} - {field_mapping.field_description}',
            href=UKB_FIELD_ID_URL % field_mapping.field_id,
            target="_blank"
        )),
        html.P(selected_row['approach']),
        html.Table([
                # TODO: retrieve concept_name, domain, vocab from Athena and include link to Athena.
                html.Tr(
                    [html.Td(html.B("Event")), html.Td(','.join(map(str, field_mapping.event_targets)))]
                )
                ,html.Tr(
                    [html.Td(html.B("Unit")), html.Td(str(field_mapping.unit_target))]
                )
                ,html.Tr(
                    [html.Td(html.B("Comment")), html.Td(field_mapping.comment)]
                )
            ]
        ),
        # TODO: include list of value mappings.
        html.Code(str(field_mapping))
    ]


if __name__ == '__main__':
    app.run_server(debug=True)
