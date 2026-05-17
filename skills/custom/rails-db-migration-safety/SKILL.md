---
name: rails-db-migration-safety
description: Use when creating, reviewing, or modifying Rails database migrations, schema changes, data migrations, indexes, backfills, column or table renames, or production database changes. Focus on reversibility, locking risk, deploy sequencing, and rollback safety.
---

# Rails DB Migration Safety

Use this skill for Rails schema and data changes.

## Before editing

1. Identify database adapter, schema format, Rails version, and whether `strong_migrations` or similar tooling is installed.
2. Inspect existing migration style and naming.
3. Determine whether the change affects a large or hot table.

## Safety checklist

- Prefer reversible migrations or explicitly define `up` and `down`.
- Avoid combining schema changes and large data backfills in one migration.
- For PostgreSQL indexes on large tables, consider concurrent indexes and `disable_ddl_transaction!`.
- Avoid dangerous single-step renames in production; use expand-and-contract deploys when needed.
- Add nullable columns first, backfill separately, then enforce constraints in a later deploy when appropriate.
- Keep application code compatible across rolling deploys.

## Validation

- Run migration locally in test/development when feasible.
- Run rollback for reversible changes when feasible.
- Inspect generated schema diffs.
- Document deploy sequencing, manual backfills, and rollback limitations.
