-- https://github.com/OHDSI/CommonDataModel/blob/master/PostgreSQL/OMOP%20CDM%20postgresql%20ddl.txt

--HINT DISTRIBUTE ON RANDOM
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


--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.vocabulary (
    vocabulary_id			VARCHAR(20)		NOT NULL,
    vocabulary_name		VARCHAR(255)	NOT NULL,
    vocabulary_reference	VARCHAR(255)	NOT NULL,
    vocabulary_version	VARCHAR(255)	NULL,
    vocabulary_concept_id	INTEGER			NOT NULL
)
;


--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.domain (
    domain_id			    VARCHAR(20)		NOT NULL,
    domain_name		    VARCHAR(255)	NOT NULL,
    domain_concept_id		INTEGER			NOT NULL
)
;


--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.concept_class (
    concept_class_id			VARCHAR(20)		NOT NULL,
    concept_class_name		VARCHAR(255)	NOT NULL,
    concept_class_concept_id	INTEGER			NOT NULL
)
;


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


--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.concept_synonym (
    concept_id			INTEGER			NOT NULL,
    concept_synonym_name	VARCHAR(1000)	NOT NULL,
    language_concept_id	INTEGER			NOT NULL
)
;


--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.concept_ancestor (
    ancestor_concept_id		INTEGER		NOT NULL,
    descendant_concept_id		INTEGER		NOT NULL,
    min_levels_of_separation	INTEGER		NOT NULL,
    max_levels_of_separation	INTEGER		NOT NULL
)
;


--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.source_to_concept_map (
    source_code				VARCHAR(50)		NOT NULL,
    source_concept_id			INTEGER			NOT NULL,
    source_vocabulary_id		VARCHAR(20)		NOT NULL,
    source_code_description	VARCHAR(255)	NULL,
    target_concept_id			INTEGER			NOT NULL,
    target_vocabulary_id		VARCHAR(20)		NOT NULL,
    valid_start_date			DATE			NOT NULL,
    valid_end_date			DATE			NOT NULL,
    invalid_reason			VARCHAR(1)		NULL
)
;


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


--HINT DISTRIBUTE ON RANDOM
CREATE TABLE vocab.attribute_definition (
    attribute_definition_id		  INTEGER			  NOT NULL,
    attribute_name				      VARCHAR(255)	NOT NULL,
    attribute_description			  TEXT	NULL,
    attribute_type_concept_id		INTEGER			  NOT NULL,
    attribute_syntax				    TEXT	NULL
)
;