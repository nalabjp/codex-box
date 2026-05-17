# codex-box

## Setup

### Environment

| Key | Value |
| --- | --- |
| GITHUB_REPO | [owner/repo] |
| GITHUB_TOKEN | PAT |

### Setup script

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nalabjp/codex-box/HEAD/setup.sh)"
```

## Codex skills

Skills are installed at Codex user scope with `gh skill install --agent codex --scope user`, which resolves to `~/.codex/skills/`. This keeps the same skills available across repositories and avoids mixing third-party OSS skills into each project checkout.

This repository still keeps the custom skill sources under `skills/custom/` so they can be reviewed, versioned, and installed by `setup.sh`.

### OSS skills installed by `setup.sh`

- `ComposioHQ/awesome-codex-skills` `gh-fix-ci`
- `ComposioHQ/awesome-codex-skills` `gh-address-comments`
- `opensite-ai/opensite-skills` `rails-query-optimization`
- `opensite-ai/opensite-skills` `rails-zero-downtime-migrations`
- `opensite-ai/opensite-skills` `postgres-performance-engineering`
- `opensite-ai/opensite-skills` `sidekiq-job-patterns`
- `win4r/goal-prompt-builder` `goal-prompt-builder`

### Custom skills maintained here

- `git-safe-change-workflow`
- `github-pr-lifecycle`
- `github-actions-rails-ci`
- `ruby-bundler-maintenance`
- `ruby-version-upgrade`
- `rails-maintenance`
- `rails-db-migration-safety`
- `rails-test-debugger`
