"""General utility module."""

from typing import Dict, Any

import pandas as pd


def is_null_or_falsy(value: Any) -> bool:
    """
    Check whether the provided value is null/falsy.

    pandas.isnull is used to determine whether a value qualifies as
    null.

    Parameters
    ----------
    value : Any
        Value to check.

    Returns
    -------
    bool
        Return True if value is null or falsy.
    """
    if pd.isnull(value) or not value:
        return True
    else:
        return False


def replace_substrings(string: str, mapping: Dict[str, str]) -> str:
    """
    Replace substrings in string, based on the items in mapping.

    Parameters
    ----------
    string: str
        The string to be edited.
    mapping: dict of {str : str}
        Dictionary containing the replacements as {old: new}.

    Returns
    -------
    str
        The provided string after replacements.
    """
    for old, new in mapping.items():
        string = string.replace(old, new)
    return string
