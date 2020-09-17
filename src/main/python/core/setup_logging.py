# Copyright 2020 The Hyve
#
# Licensed under the GNU General Public License, version 3,
# or (at your option) any later version (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

import logging.config
import time
from pathlib import Path

import yaml


def setup_logging(debug: bool):
    """
    Setup logging configuration
    :param debug: flag if debug messages should be displayed
    """
    log_dir = Path('./logs')
    log_dir.mkdir(exist_ok=True)
    time_string = time.strftime('%Y-%m-%dT%H%M%S')
    logfile = log_dir.joinpath(f'{time_string}.log')

    default_level = logging.DEBUG if debug else logging.INFO
    config_path = Path('config/logging.yml')
    if config_path.exists():
        with open(config_path, 'rt') as f:
            config = yaml.safe_load(f.read())
        config['root']['level'] = default_level
        config['handlers']['file']['filename'] = logfile
        logging.config.dictConfig(config)
    else:
        logging.basicConfig(level=default_level)
