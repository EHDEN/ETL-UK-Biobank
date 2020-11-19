BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.concept_synonym (
  concept_id			INTEGER			NOT NULL,
  concept_synonym_name	VARCHAR(1000)	NOT NULL,
  language_concept_id	INTEGER			NOT NULL
)
;
alter table vocab.concept_synonym owner to admin;

COPY vocab.CONCEPT_SYNONYM FROM program 'unzip -p /vocab CONCEPT_SYNONYM.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

CREATE INDEX idx_concept_synonym_id ON vocab.concept_synonym  (concept_id ASC);

CLUSTER vocab.concept_synonym USING idx_concept_synonym_id;
COMMIT;
