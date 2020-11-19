BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.concept_ancestor (
  ancestor_concept_id		INTEGER		NOT NULL,
  descendant_concept_id		INTEGER		NOT NULL,
  min_levels_of_separation	INTEGER		NOT NULL,
  max_levels_of_separation	INTEGER		NOT NULL
)
;

alter table vocab.concept_ancestor owner to admin;

COPY vocab.CONCEPT_ANCESTOR FROM program 'unzip -p /vocab CONCEPT_ANCESTOR.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

ALTER TABLE vocab.concept_ancestor ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY (ancestor_concept_id,descendant_concept_id);

CREATE INDEX idx_concept_ancestor_id_1 ON vocab.concept_ancestor (ancestor_concept_id ASC);
CREATE INDEX idx_concept_ancestor_id_2 ON vocab.concept_ancestor (descendant_concept_id ASC);

CLUSTER vocab.concept_ancestor USING idx_concept_ancestor_id_1;
COMMIT;
