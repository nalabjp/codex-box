---
name: git-safe-change-workflow
description: Use when Codex is asked to modify code in a Git repository and must inspect branch state, preserve user changes, make focused commits, prepare safe diffs, or avoid destructive Git operations.
---

# Git Safe Change Workflow

Use this skill before and after code edits in a Git repository.

## Pre-flight

1. Inspect repository state:
   - `git status --short`
   - `git branch --show-current`
   - `git diff --stat`
2. Treat existing uncommitted changes as user-owned unless the current task clearly created them.
3. Do not run destructive commands such as `git reset --hard`, `git checkout -- .`, `git clean -fd`, or force-push unless the user explicitly asks for them.
4. If the worktree is dirty, keep your edits narrowly scoped and avoid reformatting unrelated files.

## During edits

- Prefer small, reviewable changes.
- Preserve existing style, file layout, and project conventions.
- Use `git diff -- <path>` to inspect touched files before broad test runs.
- Do not hide unrelated failures; report them separately from your changes.

## Before commit or handoff

1. Review the final patch:
   - `git diff --stat`
   - `git diff --check`
   - `git diff`
2. Run the most specific validation commands available.
3. Commit only the intended files.
4. Write an imperative, focused commit message that names the user-visible outcome.
5. Summarize modified files, validation results, and any known follow-up risks.
