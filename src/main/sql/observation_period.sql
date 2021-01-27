
INSERT INTO omopcdm.observation_period
(
    person_id,
    observation_period_start_date,
    observation_period_end_date,
    period_type_concept_id
)
with events as (
    SELECT
        person_id, visit_start_date AS start_date, visit_end_date AS end_date
    FROM omopcdm.visit_occurrence

    UNION
    SELECT
        person_id, condition_start_date AS start_date, condition_end_date AS end_date
    FROM omopcdm.condition_occurrence

    UNION

    SELECT
        person_id, drug_exposure_start_date AS start_date, drug_exposure_end_date AS end_date
    FROM omopcdm.drug_exposure

    UNION

    SELECT
        person_id, procedure_date AS start_date, NULL AS end_date
    FROM omopcdm.procedure_occurrence

    UNION

    SELECT
        person_id, observation_date AS start_date, NULL AS end_date
    FROM omopcdm.observation

    UNION

    SELECT
        person_id, measurement_date AS start_date, NULL AS end_date
    FROM omopcdm.measurement
)
select
    person.person_id,
    min(start_date) AS observation_start_date,
    coalesce(max(death_date), greatest(max(start_date), max(end_date))) AS observation_end_date,
    32817 as observation_type_concept_id  -- EHR
FROM events
         JOIN omopcdm.person ON person.person_id = events.person_id
         LEFT JOIN omopcdm.death ON person.person_id = death.person_id  -- if death date given, that is the end date
WHERE start_date > '1970-01-01'
GROUP BY person.person_id
;