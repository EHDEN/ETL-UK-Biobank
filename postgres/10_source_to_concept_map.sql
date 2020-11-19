BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.source_to_concept_map (
    source_code				VARCHAR(50)		NOT NULL,
    source_concept_id			INTEGER			NOT NULL,
    source_vocabulary_id		VARCHAR(20)		NOT NULL,
    source_code_description	VARCHAR(255)	NULL,
    target_concept_id			INTEGER			NOT NULL,
    target_vocabulary_id		VARCHAR(20)		NOT NULL,
    valid_start_date			DATE			NOT NULL,
    valid_end_date			DATE			NOT NULL,
    invalid_reason			VARCHAR(1)		NULL
)
;
alter table vocab.source_to_concept_map owner to admin;
COMMIT;
