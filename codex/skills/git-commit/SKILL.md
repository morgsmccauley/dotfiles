---
name: git-commit
description: Create a focused git commit from the current working tree using conventional commits. Use when the user asks to commit changes, write a commit message, choose a commit type like feat or fix, stage the right files, or turn a finished edit into a clean commit without scooping up unrelated work.
---

# Git Commit

Inspect the working tree before staging anything.

- Run `git status --short` to see tracked, modified, and untracked files.
- Run targeted `git diff` or `git diff -- <path>` on the files that appear relevant.
- If files are already staged, inspect `git diff --cached` before committing.

Commit only the intended change.

- Stage only the files that belong to the requested task.
- If unrelated changes are present, leave them unstaged instead of bundling them into the commit.
- Do not amend an existing commit unless the user explicitly asks for that.
- Prefer non-interactive git commands.

Write a commit message that explains the change cleanly.

- Prefer a single well-scoped commit.
- Use conventional commits for the subject line, such as `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`, or `perf:`.
- Follow any repository-specific commit convention if it is obvious and differs from the default list above.
- Prefer messages that capture why the change exists, not just what files changed.
- Keep the subject line short and specific.

Verify the result after committing.

- Run `git status --short` to confirm the intended files were committed.
- Return the commit hash and commit message in the final response.
