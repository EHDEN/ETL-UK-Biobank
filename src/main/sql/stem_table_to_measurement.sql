
INSERT INTO @target_schema.measurement
(
	person_id,
	measurement_concept_id,
	measurement_date,
	measurement_datetime,
	measurement_type_concept_id,
	operator_concept_id,
	value_as_number,
	value_as_concept_id,
	unit_concept_id,
	range_low,
	range_high,
	provider_id,
	visit_occurrence_id,
	visit_detail_id,
	measurement_source_value,
	measurement_source_concept_id,
	unit_source_value,
	value_source_value,
	data_source
)
SELECT
	stem_table.person_id AS person_id,

    coalesce(stem_table.concept_id, 0) AS measurement_concept_id,

	stem_table.start_date AS measurement_date,

	stem_table.start_datetime AS measurement_datetime,

	stem_table.type_concept_id AS measurement_type_concept_id,

	stem_table.operator_concept_id AS operator_concept_id,

	stem_table.value_as_number AS value_as_number,

	stem_table.value_as_concept_id AS value_as_concept_id,

	stem_table.unit_concept_id AS unit_concept_id,

	stem_table.range_low AS range_low,

	stem_table.range_high AS range_high,

	stem_table.provider_id AS provider_id,

	stem_table.visit_occurrence_id AS visit_occurrence_id,

	stem_table.visit_detail_id AS visit_detail_id,

	stem_table.source_value AS measurement_source_value,

    coalesce(stem_table.source_concept_id,0) AS measurement_source_concept_id,

	stem_table.unit_source_value AS unit_source_value,

	stem_table.value_source_value AS value_source_value,

    stem_table.data_source AS data_source

FROM @target_schema.stem_table
    LEFT JOIN vocab.concept USING (concept_id)
WHERE concept.domain_id = 'Measurement'
;