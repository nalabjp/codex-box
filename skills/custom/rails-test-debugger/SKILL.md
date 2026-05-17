---
name: rails-test-debugger
description: Use when investigating or fixing Ruby on Rails test failures, including RSpec, Minitest, system specs, Capybara, FactoryBot, fixtures, ActiveJob tests, time zone issues, database cleanup, or flaky tests.
---

# Rails Test Debugger

Use this skill to diagnose Rails test failures without weakening coverage.

## Reproduce narrowly

1. Identify the exact failing file, line, seed, and command.
2. Rerun the smallest failing scope before the full suite.
3. Preserve failure output and compare local vs CI environment differences.

## Diagnosis checklist

- Data setup: factories, fixtures, validations, callbacks, and uniqueness constraints.
- Time: time zones, frozen time helpers, daylight-saving behavior, and date boundaries.
- Jobs: enqueued/performed job assertions and queue adapters.
- System specs: browser driver, assets, asynchronous waits, and Capybara selectors.
- Database: transactional tests, cleanup strategy, order dependence, and leaked state.
- Randomness: seed-dependent ordering and nondeterministic factories.

## Fix rules

- Fix product code when the test exposes a real bug.
- Fix test setup when the test is invalid or brittle.
- Do not delete assertions or add excessive sleeps to hide failures.
- For flaky tests, explain the flake mechanism and add deterministic synchronization or isolation.

## Validation

Run the focused test, a related test group, and the broader suite when practical.
