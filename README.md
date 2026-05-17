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

### GitHub authentication

Git や Bundler がエージェントフェーズ中に private な GitHub リソースへアクセスする必要がある場合は、`GITHUB_TOKEN` を setup-only secret ではなく Codex の環境変数として設定してください。`setup.sh` は GitHub CLI を credential helper として使うように Git を設定し、実行時の `GITHUB_TOKEN` から `BUNDLE_GITHUB__COM` を導出する、token を含まない `~/.bashrc` snippet を書き込みます。また、従来の GCM / profile.d credential setup を削除し、Bundler config、`/etc/profile.d`、GCM、`pass`、GPG には token を永続化しません。

## Codex skills

Skills are installed at Codex user scope with `gh skill install --agent codex --scope user`, which resolves to `~/.codex/skills/`. This keeps the same skills available across repositories and avoids mixing third-party OSS skills into each project checkout.

`setup.sh` can be curl-executed from any repository checkout. It downloads this repository's `AGENTS.md` to the workspace root (falling back to `~/AGENTS.md`) and installs custom skills from `nalabjp/codex-box` directly from GitHub, so the current checkout does not need to be `codex-box`.

Custom skill sources live under `skills/custom/` for review and versioning, and `setup.sh` installs those skills from `nalabjp/codex-box` into Codex user scope (`~/.codex/skills/`) so they are available in every Codex environment and repository checkout.

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
