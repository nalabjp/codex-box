---
name: rails-maintenance
description: Use when modifying Ruby on Rails applications, including models, controllers, views, routes, jobs, mailers, migrations, tests, assets, credentials, or Rails configuration. Inspect Rails version, test framework, schema style, frontend stack, and conventions before editing.
---

# Rails Maintenance

Use this skill for general Rails application changes.

## Project discovery

1. Inspect Ruby and Rails versions with project-safe commands such as `ruby -v`, `bundle exec rails -v`, or `bin/rails -v`.
2. Identify test framework: `spec/` for RSpec, `test/` for Minitest, or both.
3. Identify schema format: `db/schema.rb` or `db/structure.sql`.
4. Identify background job system, mailers, cache, and frontend stack when touched.
5. Read nearby tests and existing patterns before editing.

## Rails conventions

- Use Rails generators only when they match existing project conventions.
- Keep controllers thin and prefer model/service/query objects only when the project already uses them.
- Preserve routing conventions and named route usage.
- Do not print credentials, master keys, tokens, or production env values.
- Do not run commands against production databases unless explicitly requested.

## Validation options

Choose the narrowest useful checks:

- `bundle exec rails test` or targeted Minitest files
- `bundle exec rspec` or targeted RSpec examples
- `bin/rails zeitwerk:check`
- `bin/rails routes` for routing changes
- `bin/rails db:migrate` and rollback checks for migrations
