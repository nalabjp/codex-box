---
name: ruby-bundler-maintenance
description: Use when working with Ruby dependencies, Gemfile, Gemfile.lock, Bundler, gem upgrades, security updates, Ruby version constraints, native extension failures, or dependency resolution conflicts.
---

# Ruby Bundler Maintenance

Use this skill for Ruby dependency work.

## Inspect first

1. Read `.ruby-version`, `Gemfile`, `Gemfile.lock`, and relevant CI or Docker configuration.
2. Run `ruby -v`, `bundle -v`, and `bundle check` when available.
3. Determine whether the task is a targeted update, security update, Ruby upgrade, or dependency conflict.

## Update rules

- Prefer targeted commands such as `bundle update <gem>` over broad `bundle update`.
- Keep `Gemfile.lock` changes explainable.
- Do not change Ruby version managers, global gem paths, or system Ruby configuration unless requested.
- Use `bundle exec` for project commands.
- For private gem sources, avoid printing tokens or credentials.

## Troubleshooting

- For native extension failures, inspect compiler packages, Ruby headers, platform-specific lockfile entries, and gem release notes.
- For version conflicts, identify the tightest constraint and the gem that owns it.
- For security updates, update to the minimum safe version unless the user asks for a broader upgrade.

## Validation

Run the project’s targeted tests and a dependency sanity check such as `bundle check` or the relevant CI command.
