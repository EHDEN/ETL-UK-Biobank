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

from delphyne.config.models import MainConfig
from sqlalchemy import create_engine
import glob

logger = logging.getLogger(__name__)


def initialize_database(config: MainConfig, do_force_vocab_load = False):
    db_config = config.database
    # superuser = config
    superuser_eng = create_engine('postgresql://%s:%s@%s:%s/%s' % (
        'postgres',
        'password',
        db_config.host,
        db_config.port,
        db_config.database_name
    ))

    # Use superuser for vocabulary loading
    connection = superuser_eng.connect()

    logger.info('{:-^100}'.format('Vocabulary loading'))

    # Check if concept table exists. If so, assume vocab schema is loaded.
    try:
        connection.execute("SELECT * FROM vocab.concept;")
        logger.info('Vocabulary tables already loaded.')
        vocabularies_loaded = True
    except:
        logger.info('Vocabulary concept table not found, starting loading vocabularies...')
        vocabularies_loaded = False

    if vocabularies_loaded and do_force_vocab_load:
        logger.info('Forcing reloading of vocabularies')
        connection.execute('DROP SCHEMA vocab CASCADE;')

    if not vocabularies_loaded or do_force_vocab_load:
        # If selecting failed, load the vocabulary.
        for sql_file in sorted(glob.glob('postgres/*.sql')):
            logger.info('{:-^100}'.format('Processing ' + sql_file))
            try:
                connection.execute(open(sql_file, 'r').read())
                logger.info('Success.')
            except Exception as e:
                logger.warning(e)

    logger.info(connection.execute("SELECT vocabulary_version FROM vocab.vocabulary WHERE vocabulary_id = 'None';").first())
    logger.info(connection.execute("SELECT count(*) FROM vocab.vocabulary;").first())

    connection.close()