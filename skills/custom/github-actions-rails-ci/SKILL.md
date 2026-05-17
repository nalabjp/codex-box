---
name: github-actions-rails-ci
description: Use when debugging failing GitHub Actions CI for Ruby on Rails projects, including Bundler failures, Rails test failures, RSpec or Minitest failures, database setup errors, system specs, service containers, migration errors, Zeitwerk errors, and flaky Rails tests.
---

# GitHub Actions Rails CI

Use this skill after the generic GitHub CI failure has been identified, or alongside `gh-fix-ci`.

## Collect failure context

1. Use `gh pr checks` or `gh run view --log-failed` to identify the failing job and step.
2. Capture the exact failing command, Ruby version, Rails version, database service, and relevant env vars without printing secrets.
3. Compare the CI command with local equivalents in `bin/`, `Gemfile`, `.ruby-version`, `.github/workflows/`, and project docs.

## Common Rails CI checks

- Bundler: use `bundle exec`; avoid broad `bundle update` unless dependency resolution requires it.
- Database: verify PostgreSQL/MySQL service, `DATABASE_URL`, schema load, and pending migrations.
- RSpec: rerun the specific failing example when possible.
- Minitest: rerun the specific test file or line when possible.
- System specs: inspect browser setup, driver config, assets build, and headless mode.
- Zeitwerk: run `bin/rails zeitwerk:check` when autoloading errors appear.
- Assets: identify whether the app uses importmap, jsbundling-rails, webpacker, Vite, Sprockets, or Propshaft.

## Fix policy

- Prefer minimal changes that address the failing CI cause.
- Do not weaken tests solely to pass CI.
- Treat flaky-test fixes separately from product-code fixes.
- Document any CI-only behavior and why it differs from local execution.
