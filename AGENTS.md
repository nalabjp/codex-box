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

# Pull Request Policy

When creating pull requests, use GitHub CLI (`gh pr create`) rather than PR-creation tools such as `make_pr`.

Because `gh pr create` is a GitHub write operation, do not run it unless the user explicitly approves PR creation in the current conversation.

Before running `gh pr create`, show the exact command, target repository, source branch, base branch, PR title, and PR body summary, then wait for explicit user approval.

If PR creation is not approved, provide the proposed PR title and body in the final response instead of invoking any PR creation tool.
