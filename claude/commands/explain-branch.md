---
allowed-tools: Bash(git:*), Read, Glob, Grep
description: Explain the current branch changes in depth before merging
---

## Context

- Current branch: !`git branch --show-current`
- Commits on this branch: !`git log --oneline main..HEAD 2>/dev/null || git log --oneline master..HEAD`
- Files changed: !`git diff --name-only main..HEAD 2>/dev/null || git diff --name-only master..HEAD`
- Diff stats: !`git diff --stat main..HEAD 2>/dev/null || git diff --stat master..HEAD`

## Your task

Provide a comprehensive explanation of this branch's changes so I have full context and confidence to merge.

1. **Read all changed files** listed above in full
2. **Analyze the full diff** to understand exactly what changed
3. **Review commit messages** for intent and progression

## Output Format

### Overview
- What this branch does in 1-2 sentences
- Scope: X commits, Y files changed

### Changes Breakdown
For each logical unit of change:
- What changed
- Why (inferred from code/commits)
- How it works

### File Summary
Brief description of each modified file's role in the change.

### Key Decisions
Notable implementation choices or tradeoffs.

### Critical Review
Question the change itself:
- Does this approach make sense? Are there simpler alternatives?
- Any code that feels over-engineered or unnecessary?
- Edge cases or scenarios not handled?
- Assumptions being made that might not hold?
- Anything that smells off or could cause issues later?

### Merge Considerations
- Any dependencies or ordering concerns
- Potential conflicts to watch for
- Things to verify post-merge

### Confidence
- Clear purpose: yes/no
- Complete: yes/no
- Sensible approach: yes/no
- Issues: none or list them
