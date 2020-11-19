BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.relationship (
  relationship_id			VARCHAR(20)		NOT NULL,
  relationship_name			VARCHAR(255)	NOT NULL,
  is_hierarchical			VARCHAR(1)		NOT NULL,
  defines_ancestry			VARCHAR(1)		NOT NULL,
  reverse_relationship_id	VARCHAR(20)		NOT NULL,
  relationship_concept_id	INTEGER			NOT NULL
)
;
alter table vocab.relationship owner to admin;

COPY vocab.RELATIONSHIP FROM program 'unzip -p /vocab RELATIONSHIP.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

ALTER TABLE vocab.relationship ADD CONSTRAINT xpk_relationship PRIMARY KEY (relationship_id);

CREATE UNIQUE INDEX idx_relationship_rel_id ON vocab.relationship (relationship_id ASC);

CLUSTER vocab.relationship USING idx_relationship_rel_id;
COMMIT;
