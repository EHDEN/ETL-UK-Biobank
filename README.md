# ETL-UK-Biobank
ETL of UK-Biobank to OMOP CDM version 5.3.1.

This repository will host the ETL code, Mapping Files, Test code, and ETL Documentation.

## Requirements
### Python
All python dependencies can be installed with `pip install -r requirements.txt`

The ETL is based on [delphyne](https://github.com/thehyve/delphyne), the python OMOP ETL wrapper build by The Hyve.
Please refer to the delphyne documentation for further information on the ETL structure.

### OMOP Vocabularies
In order to run the ETL, you have to download the OMOP standard vocabulary from [Athena](athena.ohdsi.org). Keep the default selection of vocabularies and in addition select:
- READ (#17)
- ICD10 (#34)
- OPCS4 (#55)
- HES Specialty (#57)
- dm+d (#75)
- ICDO3 (#90)
- UK Biobank (#144)

## Getting Started
There are two ways to run the ETL. The first is by using Docker to set up the environment. The second is by manually setting up the environment.

### Docker setup
The ETL can be run with Docker. The only requirement is to install Docker and download the OMOP standard vocabulary from [Athena](athena.ohdsi.org).

To deploy the docker:
1. Unzip the vocabulary download and move the files to `/resources/vocabularies/standard`.
2. Run `docker-compose up -d --build`. This will build the postgres and etl containers. After building this, the etl will be started. If the vocabularies are not loaded yet, the first step will be to load these.
3. Check the progress with `docker-compose logs -f etl`. Or look at the files in the _logs_ folder. The etl image will keep retrying to run the etl until it finishes successfully.
4. When finished, you can find the transformed files in the postgres database in the Docker that can be accessed e.g. through psql (`psql -h localhost -p 6000 -d ohdsi -U admin -W`). For the password see [docker-compose.yml](docker-compose.yml), line 18. 

Note: this runs the ETL on the provided synthetic data. To run the data on your own dataset, add your csv files to a new folder here. In the [config-docker.yml](config/config-docker.yml), set this folder as the `source_data_folder`. Run the etl again by building it: `docker-compose up -d --build etl`.

The docker images (postgres and etl) can be stopped with: `docker-compose down`.

### Manual setup

#### Dependencies
- postgresql database
- python 3.7
- `pip install -r requirements.txt`

#### Prepare the target database
- Create an empty database.
- Add standard vocabularies, unzipped, `to resources/vocabularies/standard` (see also [delphyne documentation](https://delphyne.readthedocs.io/en/latest/standard_vocab.html))

#### Customize configuration
In `config/`:
- Copy and rename `config-sample.yml`, and edit the options to enable a successful connection to your target database. 
You can create multiple configurations, for example one for a local test database and one for a remote database, without name restrictions. 

#### Running the ETL

To run the ETL, execute the following from the root:
```bash
python main.py -c <custom_config.yml>
```
A log of the run will be written to `logs/<timestamp><version>.log`
