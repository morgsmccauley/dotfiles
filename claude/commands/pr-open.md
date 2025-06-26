---
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(gh pr create:*)
description: Create a pull request for the current branch
---

## Context

- Base branch: ${ARGUMENTS:-main}
- Branch diff: !`git diff ${ARGUMENTS:-main}..`
- Branch commits: !`git log --oneline ${ARGUMENTS:-main}`

## Your task

- Use the GitHub cli (`gh`) to create a pull request for the current branch pointing to the Base branch
- If possible, use the content of this conversation, as well as the Branch diff and Branch commits, to create the description and title
- Before submitting, let me know the PR contents (title/description)
