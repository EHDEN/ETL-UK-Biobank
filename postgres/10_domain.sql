BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.domain (
  domain_id			    VARCHAR(20)		NOT NULL,
  domain_name		    VARCHAR(255)	NOT NULL,
  domain_concept_id		INTEGER			NOT NULL
)
;
alter table vocab.domain owner to admin;

COPY vocab.DOMAIN FROM program 'unzip -p /vocab DOMAIN.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

ALTER TABLE vocab.domain ADD CONSTRAINT xpk_domain PRIMARY KEY (domain_id);

CREATE UNIQUE INDEX idx_domain_domain_id  ON vocab.domain (domain_id ASC);

CLUSTER vocab.domain USING idx_domain_domain_id;
COMMIT;
