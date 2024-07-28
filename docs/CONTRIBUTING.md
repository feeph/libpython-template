# Contributing

## quickstart

### one-time setup (pipx)

systemwide (as superuser):

- install pipx

as user:

```SHELL
pipx install pre-commit
```

### repository setup

This needs to be done for every cloned repository:

```SHELL
# install pre-commit hooks
for hook_type in pre-commit commit-msg post-commit pre-push ; do
    pre-commit install --allow-missing-config --hook-type $hook_type
done
```
