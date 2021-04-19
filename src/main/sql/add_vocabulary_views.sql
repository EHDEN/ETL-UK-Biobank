-- Keep vocabularies in a separate schema but create a view in OMOP schema
-- as some OHDSI packages need the data and vocabularies together.

CREATE OR REPLACE VIEW concept AS (SELECT * FROM @vocabulary_schema.concept);
CREATE OR REPLACE VIEW concept_relationship AS (SELECT * FROM @vocabulary_schema.concept_relationship);
CREATE OR REPLACE VIEW concept_ancestor AS (SELECT * FROM @vocabulary_schema.concept_ancestor);
CREATE OR REPLACE VIEW concept_synonym AS (SELECT * FROM @vocabulary_schema.concept_synonym);
CREATE OR REPLACE VIEW concept_class AS (SELECT * FROM @vocabulary_schema.concept_class);
CREATE OR REPLACE VIEW domain AS (SELECT * FROM @vocabulary_schema.domain);
CREATE OR REPLACE VIEW vocabulary AS (SELECT * FROM @vocabulary_schema.vocabulary);
CREATE OR REPLACE VIEW relationship AS (SELECT * FROM @vocabulary_schema.relationship);
CREATE OR REPLACE VIEW drug_strength AS (SELECT * FROM @vocabulary_schema.drug_strength);
CREATE OR REPLACE VIEW source_to_concept_map AS (SELECT * FROM @vocabulary_schema.source_to_concept_map);