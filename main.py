#!/usr/bin/env python3

import logging
from pathlib import Path

import click
import sys
from delphyne.config.models import MainConfig
from delphyne.log.setup_logging import setup_logging
from delphyne.util.io import read_yaml_file

from src.main.python.wrapper import Wrapper

__version__ = '1.4.1'

logger = logging.getLogger(__name__)


@click.command()
@click.option('--config', '-c', required=True, metavar='<config_file_path>',
              help='Path to the yaml configuration file.',
              type=click.Path(file_okay=True, exists=True, readable=True))
def main(config):
    # Setup logging
    setup_logging()

    # Load configuration
    config_yaml = read_yaml_file(Path(config))
    config = MainConfig(**config_yaml)

    # Initialize ETL with configuration parameters
    etl = Wrapper(config,
                  load_gp_regular=config_yaml['run_options'].get('load_gp_regular', True),
                  load_gp_covid19=config_yaml['run_options'].get('load_gp_covid19', True))

    logger.info('ETL version {}'.format(__version__))

    # Run ETL
    etl.run()


if __name__ == "__main__":
    sys.exit(main(auto_envvar_prefix='ETL'))
