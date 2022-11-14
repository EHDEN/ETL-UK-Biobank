# Open source ETL wrapper for the ETL UK Biobank project

This is an early version of the Delphyne product, released as open source in support of the publication
[“Transforming and evaluating the UK Biobank to the OMOP Common Data Model for COVID-19 research and beyond”](https://doi.org/10.1093/jamia/ocac203).
It is intended to work with [the ETL UK Biobank project](https://github.com/EHDEN/ETL-UK-Biobank), but
is otherwise not feature completed. It is based on Delphyne version 0.1.0.

Delphyne is a Python package designed to simplify and standardize the process of converting
source data into the [OMOP Common Data Model](https://www.ohdsi.org/data-standardization/the-common-data-model/).

If you are interested in using Delphyne, please contact [The Hyve](https://www.thehyve.nl/).

## Build instructions
For building the package, [Nox](https://nox.thea.codes/en/stable/) is used. In the root directory,
run `nox -s build` to build the wheel file (dist/delphyne-0.1.0a3-py3-none-any.whl) which can be used
as a dependency for the ETL UK Biobank project.

## License
[GPLv3](https://github.com/thehyve/delphyne/blob/master/LICENSE)

## Credits
This package was created with Cookiecutter and the `cs01/cookiecutter-pypackage` project template.

[Cookiecutter](https://github.com/audreyr/cookiecutter) [cs01/cookiecutter-pypackage](https://github.com/cs01/cookiecutter-pypackage)
