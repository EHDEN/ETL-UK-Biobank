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
from sqlalchemy import create_engine
import glob

logger = logging.getLogger(__name__)


def initialize_database(config):
    db_config = config['database']
    superuser = config['run_options']['initialize_db_superuser']
    superuser_eng = create_engine('postgresql://%s:%s@%s:%s/%s' % (
        superuser['username'],
        superuser['password'],
        db_config['host'],
        db_config['port'],
        db_config['database_name']
    ))

    # Use superuser for vocabulary loading
    connection = superuser_eng.connect()

    logger.info('{:-^100}'.format('Vocabulary loading'))
    # Check if concept table exists. If so, assume vocab schema is loaded.
    try:
        connection.execute("SELECT * FROM vocab.concept;")
        logger.info('Vocabulary tables already loaded')
        return
    except:
        pass

    for sql_file in sorted(glob.glob('postgres/*.sql')):
        logger.info('{:-^100}'.format('Processing ' + sql_file))
        try:
            result = connection.execute(open(sql_file, 'r').read())
            logger.info('Success.')
        except Exception as e:
            print(e)
    connection.close()
