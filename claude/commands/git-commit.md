---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`

## Your task

- Based on the above changes, create a single git commit.
- Follow conventional commits format
- if it exists, use the context of the conversation to help derive the message
- if possible, commit message should state why the change was made not what the change is
