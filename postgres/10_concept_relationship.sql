BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.concept_relationship (
  concept_id_1			INTEGER			NOT NULL,
  concept_id_2			INTEGER			NOT NULL,
  relationship_id		VARCHAR(20)		NOT NULL,
  valid_start_date		DATE			NOT NULL,
  valid_end_date		DATE			NOT NULL,
  invalid_reason		VARCHAR(1)		NULL
  )
;
alter table vocab.concept_relationship owner to admin;

COPY vocab.CONCEPT_RELATIONSHIP FROM program 'unzip -p /vocab CONCEPT_RELATIONSHIP.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

ALTER TABLE vocab.concept_relationship ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY (concept_id_1,concept_id_2,relationship_id);

CREATE INDEX idx_concept_relationship_id_1 ON vocab.concept_relationship (concept_id_1 ASC);
CREATE INDEX idx_concept_relationship_id_2 ON vocab.concept_relationship (concept_id_2 ASC);
CREATE INDEX idx_concept_relationship_id_3 ON vocab.concept_relationship (relationship_id ASC);
COMMIT;
