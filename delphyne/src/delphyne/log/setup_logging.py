"""Logging setup."""

import logging.config
import time

from .._paths import LOG_OUTPUT_DIR, LOG_CONFIG_PATH
from ..util.io import read_yaml_file


def setup_logging() -> None:
    """
    Set up logging configuration.

    Returns
    -------
    None
    """
    log_dir = LOG_OUTPUT_DIR
    log_dir.mkdir(exist_ok=True)
    time_string = time.strftime('%Y-%m-%dT%H%M%S')
    logfile = log_dir.joinpath(f'{time_string}.log')

    config_path = LOG_CONFIG_PATH
    if config_path.exists():
        config = read_yaml_file(config_path)
        config['handlers']['file']['filename'] = logfile
        logging.config.dictConfig(config)
    else:
        logging.basicConfig(level=logging.INFO)
