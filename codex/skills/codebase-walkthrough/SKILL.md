---
name: codebase-walkthrough
description: Understand and explain an unfamiliar repository by inspecting its structure, entrypoints, runtime flows, and key modules. Use when the user asks for onboarding to a new codebase, wants an architecture walkthrough, asks where to start reading, needs a feature traced end-to-end, or wants a concise explanation of how folders, services, APIs, jobs, data models, or tests fit together.
---

# Codebase Walkthrough

Build a reliable mental model of the repository before explaining details. Prefer concrete file and symbol references over generic architectural language.

## Initial Pass

Start with the smallest set of files that explains the codebase shape.

- Inspect the top-level tree first.
- Read root documentation and manifests before diving into implementation files.
- Identify the language, framework, package manager, test stack, and deployment/runtime hints from config files.
- Detect monorepo boundaries, package ownership, and generated or vendored directories that should be ignored unless directly relevant.

Use fast discovery commands when available:

- `rg --files` for repository inventory
- `rg` for framework entrypoints, route definitions, jobs, migrations, and key symbols
- `git ls-files` if the tracked file set matters
- targeted reads of README files, manifest files, and startup code

## Find the System Entry Points

Locate how the system starts and how work moves through it.

- For backend services, find the server bootstrap, routing layer, dependency wiring, background workers, and data access layer.
- For frontend apps, find the app root, router, state boundaries, page/layout structure, API clients, and component organization.
- For CLIs, find the command registration point, argument parsing, and command handlers.
- For libraries, find the public API surface, major modules, and representative usage sites or tests.
- For monorepos, identify each app or package and the edges between them before going deep into one package.

If startup differs between development and production, call that out explicitly.

## Choose the Walkthrough Mode

Match the explanation shape to the request.

- For a broad onboarding request, give a top-down architecture map first.
- For a feature question, trace one real execution path from entrypoint to side effects.
- For a "where do I start?" request, produce an ordered reading plan with the minimum useful files.
- For a debugging or change-planning request, emphasize ownership boundaries, dependencies, and likely impact areas.

When the user does not specify depth, default to:

1. a short mental model of the whole system
2. the most important files or folders
3. one representative runtime flow
4. suggested next files to read

## Trace Behavior Concretely

Prefer explaining behavior through real code paths instead of abstract layers.

- Follow request flow through files in order: transport or UI entrypoint -> controller or handler -> service or domain logic -> persistence or external APIs -> tests.
- Name the key functions, classes, or modules that carry the flow.
- Note important branching points, configuration flags, and async boundaries.
- Use tests as supporting evidence for intended behavior, especially when production code is indirect.

If the codebase is large, sample strategically instead of pretending to understand all of it. State the slice you inspected.

## Explain for Comprehension

Optimize for fast understanding, not exhaustiveness.

- Lead with what the system is, who calls it, and what it depends on.
- Group files by responsibility rather than listing directories mechanically.
- Translate project-specific terminology into plain language the first time it appears.
- Use a reading order when the user is new to the stack.
- Keep explanations layered: high-level model first, concrete file references second, lower-level details only when useful.

Useful explanation patterns:

- "Start here" list for onboarding
- "Request lifecycle" for web services
- "Render/data flow" for frontends
- "Package map" for monorepos
- "Change-impact map" for modification planning

## Distinguish Facts From Inference

Be explicit about confidence.

- Mark conclusions as confirmed when they are supported by specific files.
- Mark conclusions as inference when they are deduced from naming, structure, or partial evidence.
- Call out missing context such as undocumented environment variables, external services, or generated code that was not inspected.
- Do not invent architecture, ownership, or runtime behavior that the code does not support.

## Structure the Response

Prefer this output shape unless the user asks for something else:

1. What this codebase is
2. How it is organized
3. How execution starts
4. One important end-to-end flow
5. What to read next

Include exact file paths throughout the explanation. When useful, include line references or symbol names so the user can follow along directly in the editor.
