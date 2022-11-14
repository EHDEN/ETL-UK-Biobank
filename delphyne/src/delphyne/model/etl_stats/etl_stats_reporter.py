"""Reporting of ETL metadata statistics."""

from __future__ import annotations

import datetime
import logging
from typing import List, TYPE_CHECKING

import time

from ..._paths import LOG_OUTPUT_DIR
from ...log.log_formats import MESSAGE_ONLY
from ...log.logging_context import LoggingFormatContext

if TYPE_CHECKING:
    from .etl_stats import EtlStats, EtlTransformation

logger = logging.getLogger()


class EtlStatsReporter:
    """
    Reporter for contents of EtlStats instance.

    Can create a summary report of sources used and transformations
    performed. Either as a log report or as tab-delimited files.

    Parameters
    ----------
    etl_stats : EtlStats
        Statistics to report on.
    """

    def __init__(self, etl_stats: EtlStats):
        self.stats = etl_stats

    def log_summary(self) -> None:
        """Log summary of all sources/transformations."""
        with LoggingFormatContext(logger, MESSAGE_ONLY):
            logger.info('')
            logger.info(f'Total runtime: {datetime.datetime.now() - self.stats.start_time}')
            logger.info('')

            self._log_sources()

            vocab_transformations = [t for t in self.stats.transformations if t.is_vocab_only]
            if vocab_transformations:
                logger.info(f'Vocabulary updates: {len(vocab_transformations)} (total time: '
                            f'{self.stats.get_total_duration(vocab_transformations)})')
                self._log_transformations(vocab_transformations)

            cdm_transformations = [t for t in self.stats.transformations if not t.is_vocab_only]
            if cdm_transformations:
                logger.info(f'CDM transformations: {len(cdm_transformations)} (total time: '
                            f'{self.stats.get_total_duration(cdm_transformations)})')
                self._log_transformations(cdm_transformations)

            logger.info('Total insertions:')
            counts = {k: v for k, v in sorted(self.stats.total_insertions.items(),
                                              key=lambda item: item[1], reverse=True)}
            for table, insertion_count in counts.items():
                logger.info(f'\t{table}: {insertion_count}')

    def _log_sources(self) -> None:
        if self.stats.sources:
            logger.info(f'Source table row counts (total time: '
                        f'{self.stats.get_total_duration(self.stats.sources)}):')
            for source in self.stats.sources:
                logger.info(f'\t{source}')
            logger.info('')

    def _log_transformations(self, transformations: List[EtlTransformation]) -> None:
        successful_transformations = [t for t in transformations if t.query_success]
        if successful_transformations:
            logger.info(f'Successful transformations ({len(successful_transformations)}):')
            for transformation in successful_transformations:
                if not transformation.is_empty:
                    self._log_transformation_counts(transformation)

        failed_transformations = [t for t in transformations if not t.query_success]
        if failed_transformations:
            logger.info(f'Failed transformations ({len(failed_transformations)}):')
            for transformation in failed_transformations:
                self._log_transformation_counts(transformation)
        logger.info('')

    @staticmethod
    def _log_transformation_counts(transformation: EtlTransformation) -> None:
        logger.info(f'\t{transformation}')
        if transformation.insertion_counts:
            logger.info(f'\t\tInsertions: {dict(transformation.insertion_counts)}')
        if transformation.update_counts:
            logger.info(f'\t\tUpdates: {dict(transformation.update_counts)}')
        if transformation.deletion_counts:
            logger.info(f'\t\tDeletions: {dict(transformation.deletion_counts)}')

