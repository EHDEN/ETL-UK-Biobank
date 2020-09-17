from pathlib import Path
from typing import Dict

import yaml


def read_yaml_file(path: Path) -> dict:
    with path.open('rt') as f:
        contents = yaml.safe_load(f.read())
    return contents

def write_yaml_file(contents: Dict, out_path: Path) -> None:
    with out_path.open('w') as out:
        yaml.dump(contents, out)
