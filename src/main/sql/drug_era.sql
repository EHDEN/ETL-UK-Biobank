/* Source: https://gist.github.com/chrisknoll/a18c8e15ff66f26fac84
   Added INSERT INTO drug_era (last statement)
   Removed drug_type_concept_id from insert.
   Translated from Oracle to PostgreSQL
    - DATEADD => date + INTERVAL '1 day'
*/

WITH
    cteDrugTarget (drug_exposure_id, person_id, drug_concept_id, drug_type_concept_id, drug_exposure_start_date, drug_exposure_end_date) AS
        (
            -- Normalize DRUG_EXPOSURE_END_DATE to either the existing drug exposure end date, or add days supply, or add 1 day to the start date
            SELECT
                d.drug_exposure_id,
                d.person_id,
                c.concept_id,
                d.drug_type_concept_id,
                drug_exposure_start_date,
                COALESCE(drug_exposure_end_date,
                         drug_exposure_start_date + days_supply * INTERVAL '1 day',
                         drug_exposure_start_date + INTERVAL '1 day') AS drug_exposure_end_date
            FROM omopcdm.drug_exposure d
                     JOIN vocab.concept_ancestor ca ON ca.descendant_concept_id = d.drug_concept_id
                     JOIN vocab.concept c ON ca.ancestor_concept_id = c.concept_id
            WHERE c.vocabulary_id = 'RxNorm'
              AND c.concept_class_id = 'Ingredient'
        ),
    cteEndDates (person_id, drug_concept_id, end_date) AS -- the magic
        (
            SELECT
                person_id,
                drug_concept_id,
                event_date + -30 * INTERVAL '1 day' AS end_date -- unpad the end date
            FROM
                (
                    SELECT
                        person_id,
                        drug_concept_id,
                        event_date,
                        event_type,
                        -- this pulls the current START down from the prior rows so that the NULLs from the END DATES will contain a value we can compare with
                        MAX(start_ordinal) OVER (
                            PARTITION BY person_id, drug_concept_id
                            ORDER BY event_date, event_type
                            ROWS UNBOUNDED PRECEDING
                            )        AS start_ordinal,
                        -- this re-numbers the inner UNION so all rows are numbered ordered by the event date
                        ROW_NUMBER() OVER (
                            PARTITION BY person_id, drug_concept_id
                            ORDER BY event_date,
                                event_type
                            )        AS overall_ord
                    FROM
                        (
                            -- select the start dates, assigning a row number to each
                            SELECT
                                person_id,
                                drug_concept_id,
                                drug_exposure_start_date              AS event_date,
                                -1                                    AS event_type,
                                row_number()
                                        OVER (
                                            PARTITION BY person_id, drug_concept_id
                                            ORDER BY drug_exposure_start_date ) AS start_ordinal
                            FROM cteDrugTarget

                            UNION ALL

                            -- pad the end dates by 30 to allow a grace period for overlapping ranges.
                            SELECT
                                person_id,
                                drug_concept_id,
                                drug_exposure_end_date + 30 * INTERVAL '1 day',
                                1 AS event_type,
                                NULL
                            FROM cteDrugTarget
                        ) RAWDATA
                ) E
            WHERE (2 * e.start_ordinal) - e.overall_ord = 0
        ),
    cteDrugExposureEnds (person_id, drug_concept_id, drug_type_concept_id, drug_exposure_start_date, drug_era_end_date) AS
        (
            SELECT
                d.person_id,
                d.drug_concept_id,
                d.drug_type_concept_id,
                d.drug_exposure_start_date,
                min(e.end_date) AS era_end_date
            FROM cteDrugTarget d
                     JOIN cteEndDates e
                          ON d.person_id = e.person_id
                              AND d.drug_concept_id = e.drug_concept_id
                              AND e.end_date >= d.drug_exposure_start_date
            GROUP BY
                d.drug_exposure_id,
                d.person_id,
                d.drug_concept_id,
                d.drug_type_concept_id,
                d.drug_exposure_start_date
        )
INSERT INTO omopcdm.drug_era (
    drug_era_id,
    person_id,
    drug_concept_id,
    drug_era_start_date,
    drug_era_end_date,
    drug_exposure_count
)
SELECT
    ROW_NUMBER() OVER (ORDER BY person_id),
    person_id,
    drug_concept_id,
    -- drug_type_concept_id,
    MIN(drug_exposure_start_date),
    drug_era_end_date,
    COUNT(*)
FROM cteDrugExposureEnds
GROUP BY person_id, drug_concept_id, drug_type_concept_id, DRUG_ERA_END_DATE
ORDER BY person_id, drug_concept_id
;