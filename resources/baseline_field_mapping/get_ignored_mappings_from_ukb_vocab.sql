select
    source_numeric.concept_code as "sourceCode",
    source_numeric.concept_name as "sourceName",
    -1 as "sourceFrequency",
    '' as "sourceAutoAssignedConceptIds",
    0 as "matchScore",
    'UNREVIEWED' as "equivalence",
    'IGNORED' as "mappingStatus",
    '' as "statusSetBy",
    0 as "statusSetOn",
    0 as "conceptId",
    'Unmapped' as "conceptName",
    '' as "domainId",
    'MAPS_TO' as "mappingType",
    '' as "comment",
    '<athena>' as "createdBy",
    round(extract(epoch from now())) as "createdOn",
    '' as "assignedReviewer"
from (select source.concept_id, source.concept_name, source.concept_code, source.vocabulary_id, source.concept_class_id
      from vocab.concept source
      left join vocab.concept_relationship cra on cra.concept_id_1 = concept_id and
                (cra.relationship_id like 'Has Answer' or cra.relationship_id like 'Has Value')
      where cra.concept_id_2 is null and source.vocabulary_id = 'UK Biobank'
        and concept_class_id in ('Variable', 'Question')
        -- exclude some administrative and all fields on wearable data (90xxx)
        and ( -- strpos(source.concept_name, 'device ID') > 0
        -- or strpos(source.concept_name, 'acquisition time') > 0
         strpos(source.concept_name, 'timestamp') > 0
        or strpos(source.concept_name, 'timestamp (pilot)') > 0
        or strpos(source.concept_name, 'assay date') > 0
        or strpos(source.concept_name, ' flag') > 0
        or (left(source.concept_code, 1) = '9' and cast(source.concept_code as integer) between 90000 and 91000))
     ) as source_numeric
where source_numeric.vocabulary_id = 'UK Biobank'
order by source_numeric.concept_code
;