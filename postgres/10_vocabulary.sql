BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.vocabulary (
  vocabulary_id			VARCHAR(20)		NOT NULL,
  vocabulary_name		VARCHAR(255)	NOT NULL,
  vocabulary_reference	VARCHAR(255)	NOT NULL,
  vocabulary_version	VARCHAR(255)	NULL,
  vocabulary_concept_id	INTEGER			NOT NULL
)
;
alter table vocab.vocabulary owner to admin;

COPY vocab.VOCABULARY FROM '/VOCABULARY_CPT4.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;
COPY vocab.VOCABULARY FROM program 'unzip -p /vocab VOCABULARY.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

ALTER TABLE vocab.vocabulary ADD CONSTRAINT xpk_vocabulary PRIMARY KEY (vocabulary_id);

CREATE UNIQUE INDEX idx_vocabulary_vocabulary_id ON vocab.vocabulary (vocabulary_id ASC);

CLUSTER vocab.vocabulary USING idx_vocabulary_vocabulary_id;
COMMIT;
