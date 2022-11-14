"""ETL metadata statistics."""

import copy
import datetime
import logging
from abc import ABC, abstractmethod
from collections import Counter
from contextlib import contextmanager
from dataclasses import dataclass, field
from typing import Optional, Union, List, Dict, ClassVar, ContextManager

import pandas as pd
from itertools import chain

from ...database.constraints import VOCAB_TABLES

logger = logging.getLogger()


@dataclass
class _AbstractEtlBase(ABC):
    start: datetime.datetime = field(default_factory=datetime.datetime.now)
    end: Optional[datetime.datetime] = None

    @abstractmethod
    def __str__(self):
        pass

    @property
    def duration(self) -> Optional[datetime.timedelta]:
        """Time between start and end."""
        if self.start is not None and self.end is not None:
            return self.end - self.start

    def end_now(self):
        """Set current time as the end time."""
        self.end = datetime.datetime.now()

    def to_dict(self) -> Dict:
        """Convert all properties into a dictionary."""
        d = self.__dict__
        d['duration'] = self.duration
        return d


@dataclass
class EtlSource(_AbstractEtlBase):
    """Metadata storage unit for source tables/files."""

    source_name: str = ''
    n_rows: Optional[int] = None

    df_column_order: ClassVar = ['source_name', 'n_rows', 'duration', 'start', 'end']

    def __str__(self):
        """Return name, rows and duration (if available)."""
        if self.duration is not None:
            return f'{self.source_name}: {self.n_rows} ({self.duration})'
        else:
            return f'{self.source_name}: {self.n_rows}'

    def to_dict(self) -> Dict:
        """Convert all properties into a dictionary."""
        return super().to_dict()


@dataclass
class EtlTransformation(_AbstractEtlBase):
    """Metadata storage unit for data mutation calls."""

    name: str = ''
    query_success: bool = True
    insertion_counts: Counter = field(default_factory=Counter)
    deletion_counts: Counter = field(default_factory=Counter)
    update_counts: Counter = field(default_factory=Counter)

    df_column_order: ClassVar = ['name', 'query_success', 'insertion_counts', 'update_counts',
                                 'deletion_counts', 'duration', 'start', 'end']

    def __str__(self):
        """Return name and duration."""
        return f'{self.name} ({self.duration})'

    @property
    def is_empty(self) -> bool:
        """Return True if there are no insertions/updates/deletions."""
        return (not self.insertion_counts
                and not self.deletion_counts
                and not self.update_counts)

    @property
    def is_vocab_only(self) -> bool:
        """All mutations are exclusively on vocabulary tables."""
        tables = {table.rsplit('.', 1)[-1] for table in chain(self.insertion_counts.keys(),
                                                              self.update_counts.keys(),
                                                              self.deletion_counts.keys())}
        is_vocab_table = [table in VOCAB_TABLES for table in tables]
        return all(is_vocab_table)


class EtlStats:
    """
    Metadata storage unit for ETL statistics.

    Can contain:
     - list of transformations executed with script name, target table,
       start time, end time, status (exceptions) and number of affected
       rows (**EtlTransformation**).
     - list of source tables with file/table name and raw input row
       counts (**EtlSource**).

    Attributes
    ----------
    start_time : datetime.datetime
        Time of initialization.
    transformations : list of EtlTransformation
        Stores all ETL transformation metadata.
    sources : list of EtlSource
        Stores all source file metadata.
    """

    def __init__(self):
        self.start_time = datetime.datetime.now()
        self.transformations: List[EtlTransformation] = []
        self.sources: List[EtlSource] = []

    @property
    def n_queries_executed(self) -> int:
        """Total number of transformations stored."""
        return len(self.transformations)

    @property
    def successful_transformations(self) -> List[EtlTransformation]:
        """Total number of successful transformations."""
        return [t for t in self.transformations if t.query_success]

    @property
    def total_insertions(self) -> Counter:
        """Total insertion counts of all transformations."""
        return sum((t.insertion_counts for t in self.successful_transformations), Counter())

    def reset(self) -> None:
        """
        Remove all stored Etl objects from this instance.

        Returns
        -------
        None
        """
        self.start_time = datetime.datetime.now()
        self.transformations = []
        self.sources = []

    @staticmethod
    def get_total_duration(etl_objects: Union[List[EtlTransformation], List[EtlSource]]
                           ) -> datetime.timedelta:
        """
        Get total duration of all provided objects combined.

        Parameters
        ----------
        etl_objects : list of EtlTransformation or EtlSource
            Objects to get total duration of.

        Returns
        -------
        datetime.timedelta
            Total duration.
        """
        durations = (obj.duration for obj in etl_objects if obj.start and obj.end)
        return sum(durations, datetime.timedelta())

    def add_transformation(self, transformation: EtlTransformation) -> None:
        """
        Add EtlTransformation to stored transformations.

        Parameters
        ----------
        transformation : EtlTransformation

        Returns
        -------
        None
        """
        self.transformations.append(transformation)

    def add_source(self, source: EtlSource) -> None:
        """
        Add EtlSource to stored sources.

        Parameters
        ----------
        source : EtlSource

        Returns
        -------
        None
        """
        self.sources.append(source)


etl_stats = EtlStats()


@contextmanager
def open_transformation(name: str, **kwargs) -> ContextManager[EtlTransformation]:
    """
    Wrap an EtlTransformation for tracking changes.

    Unless provided otherwise via kwargs, start and end time will be set
    to the time of entering and closing the with statement respectively.
    The created instance will be automatically added to the etl_stats
    collection.

    Parameters
    ----------
    name : str
        Name describing the current transformation.
    **kwargs
        These parameters will be passed on to the EtlTransformation
        constructor.

    Yields
    ------
    EtlTransformation
        Instance to track table changes.
    """
    transformation = EtlTransformation(name=name, **kwargs)
    try:
        yield transformation
    finally:
        if transformation.end is None:
            transformation.end_now()
        etl_stats.add_transformation(transformation)
