#!/bin/bash
#
# prepare the newly installed project
# (this script will be run in the root of the generated project)
#
# https://cookiecutter.readthedocs.io/en/2.0.2/advanced/hooks.html

set -e
set -u

echo "-- initialize repository --"
git init
git config --local user.name {{ cookiecutter.author_name }}
git config --local user.email {{ cookiecutter.author_email }}

git branch -M {{ cookiecutter.default_branch }}
#git remote add origin https://github.com/{{ cookiecutter.github_alias }}/{{ cookiecutter.repository_name }}.git
git remote add origin git@github.com:{{ cookiecutter.github_alias }}/{{ cookiecutter.repository_name }}.git

echo "-- initialize git hooks --"
for hook_type in pre-commit commit-msg post-commit pre-push ; do
    pre-commit install --allow-missing-config --hook-type $hook_type
done
pre-commit validate-config

echo "-- initialize PDM and install dependencies --"
pdm lock
pdm install

echo "-- prepare the first commit --"
git add --all
pre-commit run --all-files
echo "---------------------------------------------------------------------"
echo "All good. Please execute the following commands to finalize:"
echo "---------------------------------------------------------------------"
# 'git commit' may require manual input to sign the commit
echo "cd {{ cookiecutter.repository_name }}"
echo "git commit -m 'chore: initialize the repository'"
echo "git push --set-upstream origin master"
