"""Main config models and validation."""

from typing import Optional, Dict

from pydantic import BaseModel, validator, SecretStr, DirectoryPath

from ...cdm.schema_placeholders import VOCAB_SCHEMA, CDM_SCHEMA

_REQUIRED_SCHEMAS = [VOCAB_SCHEMA, CDM_SCHEMA]


class _DataBase(BaseModel):
    drivername: Optional[str]
    host: str
    port: int
    database_name: str
    username: str
    password: Optional[SecretStr]
    query: Optional[Dict[str, str]]

    @validator('drivername', always=True)
    def missing_drivername(cls, drivername):
        # Set postgresql as the default driver
        return drivername or 'postgresql'

    @validator('password', always=True)
    def missing_password(cls, password):
        if password is None:
            password = SecretStr('')
        return password


class _RunOptions(BaseModel):
    skip_vocabulary_loading: bool
    skip_custom_vocabulary_loading: bool
    skip_source_to_concept_map_loading: bool
    write_reports: bool


class MainConfig(BaseModel):
    """Data schema and validator of the main config properties."""

    database: _DataBase
    source_data_folder: Optional[DirectoryPath]
    schema_translate_map: Dict[str, str]
    run_options: _RunOptions
    sql_parameters: Optional[Dict[str, str]]

    @validator('schema_translate_map')
    def check_required_schemas(cls, schema_map: Dict[str, str]) -> Dict[str, str]:
        """
        Check whether the required schemas are present in schema_map.

        Parameters
        ----------
        schema_map : dict of {str : str}
            Placeholder to actual schema name mapping.

        Returns
        -------
        dict of {str : str}
            The validated schema_map.
        """
        for schema in _REQUIRED_SCHEMAS:
            if schema not in schema_map:
                raise ValueError(f'Missing required key in schema_translate_map: {schema}')
        return schema_map

    @validator('schema_translate_map', 'sql_parameters')
    def no_empty_strings(cls, str_dict: Optional[Dict[str, str]]) -> Optional[Dict[str, str]]:
        """
        Check no empty strings are provided in the dictionary.

        Parameters
        ----------
        str_dict : dict of {str : str}, optional
            Mapping object to validate.

        Returns
        -------
        dict of {str : str} or None
            The validated dictionary if provided.
        """
        if str_dict is None:
            return str_dict
        for k, v in str_dict.items():
            if k == '' or v == '':
                raise ValueError(f'Strings cannot be empty: {k}: {v}')
        return str_dict

    @validator('schema_translate_map', 'sql_parameters')
    def values_are_not_also_keys(cls,
                                 str_dict: Optional[Dict[str, str]]
                                 ) -> Optional[Dict[str, str]]:
        """
        Make sure that a value is not also a key.

        Parameters
        ----------
        str_dict : dict of {str : str}, optional
            Mapping object to validate.

        Returns
        -------
        dict of {str : str} or None
            The validated dictionary if provided.
        """
        if str_dict is None:
            return str_dict
        for k, v in str_dict.items():
            if v in str_dict and not v == k:
                raise ValueError(f'Mapping value used as key: {v}')
        return str_dict
