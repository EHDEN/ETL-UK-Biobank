
INSERT INTO @cdm_schema.condition_occurrence
(
	person_id,
	condition_concept_id,
	condition_start_date,
	condition_start_datetime,
	condition_end_date,
	condition_end_datetime,
	condition_type_concept_id,
	stop_reason,
	provider_id,
	visit_occurrence_id,
	visit_detail_id,
	condition_source_value,
	condition_source_concept_id,
	condition_status_source_value,
	condition_status_concept_id,
	data_source
)
SELECT
	stem_table.person_id	AS	person_id,

	coalesce(stem_table.concept_id, 0)	AS	condition_concept_id,

	stem_table.start_date	AS	condition_start_date,

	stem_table.start_datetime	AS	condition_start_datetime,

	stem_table.end_date	AS	condition_end_date,

	stem_table.end_datetime	AS	condition_end_datetime,

	stem_table.type_concept_id	AS	condition_type_concept_id,

	stem_table.stop_reason	AS	stop_reason,

	stem_table.provider_id	AS	provider_id,

	stem_table.visit_occurrence_id	AS	visit_occurrence_id,

	stem_table.visit_detail_id	AS	visit_detail_id,

	stem_table.source_value	AS	condition_source_value,

	coalesce(stem_table.source_concept_id, 0)	AS	condition_source_concept_id,

	stem_table.condition_status_source_value	AS	condition_status_source_value,

	coalesce(stem_table.condition_status_concept_id, 0)	AS	condition_status_concept_id,

    stem_table.data_source AS data_source

FROM @cdm_schema.stem_table
    LEFT JOIN vocab.concept USING (concept_id)
WHERE (stem_table.domain_id = 'Condition') OR (stem_table.domain_id IS NULL AND concept.domain_id = 'Condition')
;