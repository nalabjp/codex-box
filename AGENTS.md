# GitHub Operation Policy

Do not perform GitHub write operations unless the user explicitly approves the exact operation in the current conversation.

GitHub write operations include, but are not limited to:

- `git push`
- `git push --force`
- `git push --tags`
- `gh pr create`
- `gh pr edit`
- `gh pr close`
- `gh pr merge`
- `gh issue create`
- `gh issue edit`
- `gh issue comment`
- `gh release create`
- `gh release upload`
- `gh workflow run`
- `gh workflow cancel`
- `gh run rerun`
- `gh repo edit`
- `gh api` with `POST`, `PATCH`, `PUT`, or `DELETE`
- `curl`, `wget`, or scripts that mutate GitHub state through the GitHub API

Read-only GitHub operations are allowed unless the user explicitly forbids GitHub access. Read-only operations include, but are not limited to:

- `git fetch`
- `git ls-remote`
- `gh auth status`
- `gh repo view`
- `gh pr view`
- `gh pr checks`
- `gh run view`
- `gh api` with `GET`

Before any GitHub write operation, show the exact command and target repository, branch, PR, issue, release, or workflow, then wait for explicit user approval.
