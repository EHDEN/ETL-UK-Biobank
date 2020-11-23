# ETL-UK-Biobank
ETL of UK-Biobank to OMOP CDM version 5.3.1.

This repository will host the ETL code, Mapping Files, Test code, and ETL Documentation.

## Getting Started

### Prepare the target database
- Create an empty database.
- OMOP vocabulary tables should be pre-loaded to a schema named `vocab`.
- Create an empty schema `omopcdm`; the ETL will automatically load the CDM 5.3.1 tables to this schema.

### Customize configuration
In `config/`:
- Copy and rename `config-sample.yml`, and edit the options to enable a successful connection to your target database. 
You can create multiple configurations, for example one for a local test database and one for a remote database, without name restrictions. 
- Copy and rename `logging-sample.yml` to `logging.yml` to customize the logging behavior (`logging.yml` is the only file name that will be recognized by the ETL).

## Running the ETL

To run the ETL, execute the following from the root:
```bash
main.py -c <custom_config.yml>
```
A log of the run will be written to `logs/<timestamp><version>.log`
