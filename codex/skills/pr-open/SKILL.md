---
name: pr-open
description: Prepare and open a GitHub pull request with the GitHub CLI. Use when the user asks to open a PR, create a pull request from the current branch, draft a PR title and body, compare against a base branch, or submit a PR with `gh pr create`.
---

# Gh Pr Open

Inspect branch state before drafting the PR.

- Determine the base branch from user input when provided; otherwise default to `main`.
- Check the current branch name before opening a PR.
- Inspect the branch diff and commit list against the base branch so the title and body match the actual changes.

Prepare the branch if needed.

- If the current branch is the base branch, create a new branch with a sensible name before opening the PR.
- If HEAD is detached, treat that as a normal workflow, especially when detached at `origin/main`. Create a new branch from the current commit before opening the PR.
- Push the branch if it is not yet on the remote.
- Prefer non-interactive `git` and `gh` commands.

Draft the PR before submission.

- Use the conversation context, commit list, and diff to draft the title and description.
- Show the proposed title and body to the user and wait for approval before running `gh pr create`.
- Keep the title concise and specific.

Use this PR body structure unless the repository already has a stronger convention:

```md
# Summary
[Briefly describe the overall changes]

# Changes
- [Concrete change]
- [Concrete change]
```

Submit and open the PR after approval.

- Run `gh pr create` against the chosen base branch.
- Open the created PR URL in the browser.
- Return the PR URL in the final response.
