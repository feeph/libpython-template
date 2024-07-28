# pypackage-template

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![copier](https://img.shields.io/badge/copier-ab79d2)](https://copier.readthedocs.io/)


copier template for Python-based libraries / packages

- opinionated
- use namespace packages to avoid naming collisions
- use pdm, pyenv & tox for all our development needs
- use dependabot, pdm, pre-commit & release-please for all our packaging needs

__namespaces__

> A namespace package in Python is a way to split a single Python package across multiple directories or locations, allowing multiple packages or modules to contribute to the same package namespace. This is useful for creating modular and extensible libraries or applications where various components can be distributed independently but still belong to the same package.
>
> Namespace packages are typically used for extensibility and modularity. They’re handy when you want to create an ecosystem of plugins or modules that can be added or removed independently.

## Usage

### initializing an empty repository

We are going to create the examples files using 'pypackage-seeddata' and
then inject the template on top of it. The order is important because it
ensures we use the same values as the seeddata and the final answer file
will be created by 'pypackage-template' and thus contains all variables.

```SHELL
repo_name="libmagic-python"

git clone git@github.com:feeph/${repo_name}.git
copier copy https://github.com/feeph/pypackage-seeddata $repo_name
copier copy -a .copier/answers_pypackage.yaml -w https://github.com/feeph/pypackage-template $repo_name

cd $repo_name
scripts/prepare_repository
pdm run pytest
```

### injecting into an already existing codebase

We either have an already existing codebase or we're uninterested in the
example files. To prevent any kind of conflict we will ignore the seed
entirely.

```SHELL
repo_name="libsorcery-python"

git clone git@github.com:feeph/${repo_name}.git
copier copy https://github.com/feeph/pypackage-template $repo_name

cd $repo_name
# <adjust files and commit>
```

__Adjust the directory layout as needed.__
You probably need to move some files around.

Please resist the temptation to move the code into a 'src/' directory.
 - `mypy` won't like that and complain the names don't match.
 - `pdm` will fail to package the code properly.

This is a sideeffect of using a namespace package. We must not create an
`__init__.py` file in the top-level directory and that confuses some tools.

### resync with an updated template

A script was provided to help with the update process. It assumes all answer
files comply with naming scheme `.copier/answers_<templatename>.yaml`.
This ensure we can compose multiple templates into a single repository.

```SHELL
scripts/update_copier-templates
```

## Bugs & Features

Please submit bugs and feature requests on the [issue tracker]( https://github.com/feeph/libpython-template/issues).

Contributions are always welcome.

## How to contribute

Please refer to the [Contribution guide](docs/CONTRIBUTING.md).
