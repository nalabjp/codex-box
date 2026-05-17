---
name: ruby-version-upgrade
description: Use when upgrading or changing a Ruby version in a project, including .ruby-version, Gemfile ruby constraints, Gemfile.lock RUBY VERSION, CI matrices, Dockerfiles, Heroku stack compatibility, or gem compatibility fixes.
---

# Ruby Version Upgrade

Use this skill for Ruby runtime upgrades.

## Inventory

Inspect all Ruby-version touchpoints:

- `.ruby-version`
- `Gemfile` and `Gemfile.lock`
- `.tool-versions`, `.mise.toml`, `.devcontainer`, Dockerfiles, CI workflows, Heroku config, and README setup instructions
- Native gems and Rails compatibility

## Upgrade process

1. Identify target Ruby version and reason for the upgrade.
2. Update all version declarations consistently.
3. Run `bundle update --ruby` or the project’s equivalent lockfile refresh.
4. Resolve gems that block the target Ruby version with targeted updates.
5. Keep dependency changes minimal unless a broader compatibility update is required.

## Rails and Heroku notes

- Confirm the Rails version supports the target Ruby version.
- For Heroku, confirm stack/buildpack compatibility and lockfile `RUBY VERSION` before deploy.
- Watch for deprecation warnings that should be fixed before the next Rails upgrade.

## Validation

Run Bundler checks, the main test suite, boot checks, and CI matrix updates where applicable.
