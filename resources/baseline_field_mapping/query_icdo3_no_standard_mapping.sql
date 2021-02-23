-- Query to find if in the data there are icdo3 histology/behaviour-pathology codes
-- that do not have a standard mapping.
-- Some of the combinations of the above pattern should not occur hence there is no
-- no-standard to standard map in the vocabulary.

select condition_source_value, count(condition_source_value)
from omopcdm.condition_occurrence
where data_source = 'baseline' and condition_concept_id = 0
group by condition_source_value;