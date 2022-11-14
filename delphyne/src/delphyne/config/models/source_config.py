"""Source data config models and validation."""

import logging
from pathlib import Path
from typing import Optional, Dict, Any

from pydantic import BaseModel, validator, DirectoryPath
from ...util.io import is_hidden

logger = logging.getLogger(__name__)


class SourceConfig(BaseModel):
    """Data schema/validator of the source data config properties."""

    source_data_folder: DirectoryPath
    count_source_rows: bool
    file_defaults: Optional[Dict[str, Any]]
    source_files: Optional[Dict[str, Dict]]
