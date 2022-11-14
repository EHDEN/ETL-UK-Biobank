#!/usr/bin/env python

import os
from setuptools import setup, find_packages  # type: ignore

here = os.path.abspath(os.path.dirname(__file__))

# To update the package version number, edit __version__.py
version = {}
with open(os.path.join(here, 'src', 'delphyne', '_version.py')) as f:
    exec(f.read(), version)

with open("README.md") as readme_file:
    readme = readme_file.read()

setup(
    author="The Hyve",
    author_email="office@thehyve.nl",
    python_requires=">=3.7.2",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Natural Language :: English",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: Implementation :: CPython",
    ],
    description="Wrapper for OMOP ETL projects",
    install_requires=[
        "click >= 7.0, <8",
        "psycopg2-binary >= 2.8, <3",
        "pydantic >= 1.7, <2",
        "SQLAlchemy >= 1.3, <1.4",
        "SQLAlchemy-Utils >= 0.36, <1",
        "pandas >= 1.0.5, <2",
        "PyYAML >= 5.3, <6",
    ],
    license="GNU General Public License v3",
    long_description=readme,
    long_description_content_type="text/markdown",
    package_data={"delphyne": ["py.typed"]},
    include_package_data=True,
    keywords="delphyne",
    name="delphyne",
    package_dir={"": "src"},
    packages=["delphyne"],
    extras_require={
        "TEST": ["pytest", "pytest-cov", "docker", "nox", "flake8"],
    },
    url="https://github.com/thehyve/delphyne",
    version=version['__version__'],
    zip_safe=False,
)
