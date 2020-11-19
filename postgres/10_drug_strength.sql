BEGIN;
--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.drug_strength (
  drug_concept_id				INTEGER		  	NOT NULL,
  ingredient_concept_id			INTEGER		  	NOT NULL,
  amount_value					NUMERIC		    NULL,
  amount_unit_concept_id		INTEGER		  	NULL,
  numerator_value				NUMERIC		    NULL,
  numerator_unit_concept_id		INTEGER		  	NULL,
  denominator_value				NUMERIC		    NULL,
  denominator_unit_concept_id	INTEGER		  	NULL,
  box_size						INTEGER		 	NULL,
  valid_start_date				DATE		    NOT NULL,
  valid_end_date				DATE		    NOT NULL,
  invalid_reason				VARCHAR(1)  	NULL
)
;
alter table vocab.drug_strength owner to admin;

COPY vocab.DRUG_STRENGTH FROM program 'unzip -p /vocab DRUG_STRENGTH.csv' WITH DELIMITER E'\t' CSV HEADER QUOTE E'\b' FREEZE;

ALTER TABLE vocab.drug_strength ADD CONSTRAINT xpk_drug_strength PRIMARY KEY (drug_concept_id, ingredient_concept_id);

CREATE INDEX idx_drug_strength_id_1 ON vocab.drug_strength (drug_concept_id ASC);
CREATE INDEX idx_drug_strength_id_2 ON vocab.drug_strength (ingredient_concept_id ASC);

CLUSTER vocab.drug_strength USING idx_drug_strength_id_1;
COMMIT;
