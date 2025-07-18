---
allowed-tools: Bash(git diff:*), Bash(git log:*), Bash(gh pr create:*), Bash(open:*)
description: Create a pull request for the current branch
---

## Context

- Base branch: $ARGUMENTS
- Branch diff: !`git diff $ARGUMENTS..`
- Branch commits: !`git log --oneline $ARGUMENTS`

## Your task

- If $ARGUMENTS is not defined, used `main` as the base branch
- Use the GitHub cli (`gh`) to create a pull request for the current branch pointing to the Base branch
- If we are currently on the base brach, or detached, create a new branch with an appropriate name. Push the branch.
- If possible, use the content of this conversation, as well as the Branch diff and Branch commits, to create the description and title
- Let me know the contents and wait for my approval before submitting
- Execute `open` on the PR url so it is automatically opened in my browser
- PR description should follow the structure:
```md
# Summary
[Briefly describe the overall changes]
# Changes
[bullet list of the actual changes made]
```
