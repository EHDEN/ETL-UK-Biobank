
INSERT INTO @target_schema.observation
(
	person_id,
	observation_concept_id,
	observation_date,
	observation_datetime,
	observation_type_concept_id,
	value_as_number,
	value_as_string,
	value_as_concept_id,
	qualifier_concept_id,
	unit_concept_id,
	provider_id,
	visit_occurrence_id,
	visit_detail_id,
	observation_source_value,
	observation_source_concept_id,
	unit_source_value,
	qualifier_source_value,
	data_source
)
SELECT
	stem_table.person_id	AS	person_id,

	coalesce(stem_table.concept_id,0)	AS	observation_concept_id,

	stem_table.start_date	AS	observation_date,

	stem_table.start_datetime	AS	observation_datetime,

    stem_table.type_concept_id	AS	observation_type_concept_id,

	stem_table.value_as_number	AS	value_as_number,

	stem_table.value_as_string	AS	value_as_string,

	stem_table.value_as_concept_id	AS	value_as_concept_id,

	stem_table.qualifier_concept_id	AS	qualifier_concept_id,

	stem_table.unit_concept_id	AS	unit_concept_id,

	stem_table.provider_id	AS	provider_id,

	stem_table.visit_occurrence_id	AS	visit_occurrence_id,

	stem_table.visit_detail_id	AS	visit_detail_id,

	stem_table.source_value	AS	observation_source_value,

	coalesce(stem_table.source_concept_id, 0)   AS	observation_source_concept_id,

	stem_table.unit_source_value	AS	unit_source_value,

	stem_table.qualifier_source_value	AS	qualifier_source_value,

    stem_table.data_source AS data_source

FROM @target_schema.stem_table
    LEFT JOIN vocab.concept USING (concept_id)
WHERE concept.domain_id = 'Observation' OR concept.concept_id = 0
;