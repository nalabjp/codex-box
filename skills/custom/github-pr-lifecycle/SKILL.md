---
name: github-pr-lifecycle
description: Use when Codex needs to create, inspect, update, or prepare a GitHub pull request, handle review comments, check CI status, or coordinate PR readiness using gh and Git.
---

# GitHub PR Lifecycle

Use this skill for end-to-end PR work.

## Identify context

1. Confirm Git state with `git status --short` and `git branch --show-current`.
2. Confirm GitHub authentication with `gh auth status` when GitHub API access is needed.
3. Find the current PR with `gh pr view --json number,title,url,headRefName,baseRefName,state`.
4. If no PR exists, inspect branch name, commits, and diff before proposing `gh pr create`.

## PR creation checklist

- Ensure the branch contains a focused commit history.
- Include a concise title and body with:
  - Summary
  - Testing
  - Risk / rollout notes when relevant
- Do not include secrets, tokens, or private environment values.

## Review and CI loop

- Use the `gh-address-comments` skill for review-comment collection and response.
- Use the `gh-fix-ci` skill for failing GitHub Actions checks.
- Separate requested review changes from opportunistic refactors.
- After changes, rerun targeted tests and push only intentional commits.

## Handoff

Report the PR URL, notable checks, unresolved comments, and any manual follow-up needed.
