BEGIN;
-- Create table and copy are in one transaction so it fails and will not add rows again.
SET search_path = 'vocab';

CREATE TABLE vocab.concept (
  concept_id			INTEGER			NOT NULL ,
  concept_name			VARCHAR(255)	NOT NULL ,
  domain_id				VARCHAR(20)		NOT NULL ,
  vocabulary_id			VARCHAR(20)		NOT NULL ,
  concept_class_id		VARCHAR(20)		NOT NULL ,
  standard_concept		VARCHAR(1)		NULL ,
  concept_code			VARCHAR(50)		NOT NULL ,
  valid_start_date		DATE			NOT NULL ,
  valid_end_date		DATE			NOT NULL ,
  invalid_reason		VARCHAR(1)		NULL
)
;
alter table vocab.concept owner to admin;

-- Copy with FREEZE for faster loading
-- Temporary fix to include CPT4 concepts.
COPY vocab.CONCEPT FROM '/CONCEPT_CPT4.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;
COPY vocab.CONCEPT FROM program 'unzip -p /vocab CONCEPT.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;
-- TODO: custom concepts
-- TODO: load stcm

ALTER TABLE vocab.concept ADD CONSTRAINT xpk_concept PRIMARY KEY (concept_id);

CREATE UNIQUE INDEX idx_concept_concept_id  ON vocab.concept  (concept_id ASC);
CREATE INDEX idx_concept_code ON vocab.concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON vocab.concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON vocab.concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON vocab.concept (concept_class_id ASC);

CLUSTER vocab.concept USING idx_concept_concept_id;
COMMIT;
