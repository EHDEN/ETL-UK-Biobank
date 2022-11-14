"""I/O utility module."""

import hashlib
from pathlib import Path
from typing import List, Set, Dict, Optional, Union

import yaml


def read_yaml_file(path: Path) -> Dict:
    """
    Read yaml file and return as dict.

    Parameters
    ----------
    path : pathlib.Path
        File to read.

    Returns
    -------
    dict
        Contents of yaml file as dict.
    """
    with path.open('rt') as f:
        contents = yaml.safe_load(f.read())
    return contents


def is_hidden(path: Path) -> bool:
    """
    Check whether a file is hidden.

    Parameters
    ----------
    path : pathlib.Path
        The file to check.

    Returns
    -------
    bool
        Return True if the path is hidden.
    """
    return path.name.startswith(('.', '~'))


def get_all_files_in_dir(directory: Path) -> List[Path]:
    """
    Return all but the hidden files in dir.

    Parameters
    ----------
    directory : pathlib.Path
        Directory to get the contents of.

    Returns
    -------
    list of pathlib.Path
        All files that are present in the provided directory
        (non-recursive).
    """
    return [f for f in directory.glob('*')
            if f.is_file() and not is_hidden(f)]


def get_file_prefix(path: Path, suffix: str) -> Optional[str]:
    """
    Extract the part of the file name preceding the provided suffix.

    Parameters
    ----------
    path : pathlib.Path
        File to get prefix from.
    suffix : str
        String to be matched to the file name. The match only
        succeeds if the suffix is immediately preceding the file
        extension, and separated by previous characters by a dash ('_').
        The file name and prefix are both converted to lowercase before
        the matching is performed.

    Returns
    -------
    str
        Lowercase file prefix or None.
    """
    suffix = suffix.lower()
    stem = path.stem.lower()
    if stem.endswith('_' + suffix):
        prefix = stem.rsplit('_' + suffix, 1)[0]
        return prefix
    return None


def file_has_valid_prefix(path: Path, suffix: str,
                          all_prefixes: Union[List[str], Set[str]],
                          valid_prefixes: Union[List[str], Set[str]]
                          ) -> bool:
    """
    Filter file names according to specific prefix rules.

    Files should be kept (returns True) when prefix:
    - matches a given list of prefixes to process
    - is not recognized (file name has no special meaning)
    - is None (filename consists of suffix only)
    If the prefix is recognized but not in the list to parse,
    the file should be ignored (returns False).
    valid_prefixes should be a subset of all_prefixes.
    All comparisons are performed in lowercase.

    Parameters
    ----------
    path : pathlib.Path
        File to check for valid prefix.
    suffix : str
        Expected file suffix.
    all_prefixes : list of str or set of str
        Recognized prefixes that will be ignored.
    valid_prefixes : list of str or set of str
        Accepted prefixes.

    Returns
    -------
    bool
        Return True if file has a valid prefix.
    """
    # convert prefixes to lowercase
    valid_prefixes = {prefix.lower() for prefix in valid_prefixes}
    all_prefixes = {prefix.lower() for prefix in all_prefixes}

    file_prefix = get_file_prefix(path, suffix)
    if file_prefix in valid_prefixes:
        return True
    if file_prefix not in all_prefixes:
        return True
    if file_prefix is None:
        return True
    return False


def get_file_line_count(file_path: Path, skip_header: bool = True) -> int:
    """
    Get the line count of a text (non-binary) file.

    Parameters
    ----------
    file_path : pahlib.Path
        File to get the line count of.
    skip_header : bool, default True
        If True, the first line is not added to the line count.

    Returns
    -------
    int
        The file line count.
    """
    if file_path.stat().st_size == 0:  # Empty file
        return 0
    n_rows = 0
    with file_path.open('rb') as f:
        if skip_header:
            next(f)
        for _ in f:
            n_rows += 1
    return n_rows
