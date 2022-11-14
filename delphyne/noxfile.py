import nox  # type: ignore
from pathlib import Path

nox.options.sessions = ["build"]

python = ["3.8"]


lint_dependencies = [
    "flake8",
    "flake8-comprehensions",
    "flake8-docstrings",
    "flake8-bugbear",
    "check-manifest",
]


@nox.session(python=python)
def tests(session):
    session.install(".", "pytest", "pytest-cov", "docker")
    session.run("pytest", "--cov=src")
    session.notify("cover")


@nox.session(python="3.8")
def build(session):
    session.install("setuptools")
    session.install("wheel")
    session.install("twine")
    session.run("rm", "-rf", "dist", "build", external=True)
    session.run("python", "setup.py", "--quiet", "sdist", "bdist_wheel")


@nox.session(python="3.8")
def publish(session):
    """Build and publish on PyPI."""
    build(session)
    print("REMINDER: Has the changelog been updated?")
    session.run("python", "-m", "twine", "upload", "dist/*")

