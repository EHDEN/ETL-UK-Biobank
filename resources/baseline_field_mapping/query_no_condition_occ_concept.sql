select condition_source_value, count(condition_source_value)
from omopcdm.condition_occurrence
where data_source = 'baseline' and condition_concept_id = 0
group by condition_source_value;