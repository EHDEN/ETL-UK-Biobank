BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.concept_class (
  concept_class_id			VARCHAR(20)		NOT NULL,
  concept_class_name		VARCHAR(255)	NOT NULL,
  concept_class_concept_id	INTEGER			NOT NULL
)
;
alter table vocab.concept_class owner to admin;

COPY vocab.CONCEPT_CLASS FROM program 'unzip -p /vocab CONCEPT_CLASS.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

ALTER TABLE vocab.concept_class ADD CONSTRAINT xpk_concept_class PRIMARY KEY (concept_class_id);

CREATE UNIQUE INDEX idx_concept_class_class_id ON vocab.concept_class (concept_class_id ASC);

CLUSTER vocab.concept_class USING idx_concept_class_class_id;
COMMIT;
