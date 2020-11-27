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

# !/usr/bin/env python3

import logging
import sys
import click
from pathlib import Path
from src.main.python.core.yaml import read_yaml_file
from src.main.python.core import setup_logging
from src.main.python.wrapper import Wrapper
from src.main.python.core import Database
from src.main.python.initialize_database import initialize_database

__version__ = '0.1.0'

logger = logging.getLogger(__name__)

@click.command()
@click.option('--config', '-c', required=True, metavar='<config_file_path>',
              help='Path to the yaml configuration file.',
              type=click.Path(file_okay=True, exists=True, readable=True))
def main(config):

    # Load configuration
    config = read_yaml_file(Path(config))

    db = Database.from_config(config)

    # Setup logging
    debug: bool = config['run_options']['debug_mode']
    setup_logging(debug)

    # Create vocabulary schema and tables
    if config['run_options'].get('initialize_db', False):
        initialize_database(config, config['run_options'].get('force_load_vocab', False))

    # Initialize ETL with configuration parameters
    etl = Wrapper(db, config)


    logger.info('ETL version {}'.format(__version__))

    # Run ETL
    etl.run()

if __name__ == "__main__":
    sys.exit(main(auto_envvar_prefix='ETL'))
