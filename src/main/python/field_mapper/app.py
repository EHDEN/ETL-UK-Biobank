# -*- coding: utf-8 -*-

# Run this app with `python app.py` and
# visit http://127.0.0.1:8050/ in your web browser.

import dash
import dash_table
import dash_html_components as html

from pathlib import Path
from src.main.python.field_mapper.FieldConceptMapper import FieldConceptMapper

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'ERROR')

i = 0
data = []
for mapping in mapper.get_random(50):
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


app.layout = html.Div(children=[
    html.H1(children='FieldConceptMapper'),

    html.Div(children='''
        These are your fields, these are your mappings
    '''),

    dash_table.DataTable(
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
    )
])
if __name__ == '__main__':
    app.run_server(debug=True)