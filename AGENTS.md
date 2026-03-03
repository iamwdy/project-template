# Project Instructions

This repository is the base `project-template` for new projects.

## Startup Protocol

Before modifying files or running non-trivial commands in a project created from this template:

1. Read this local `AGENTS.md`.
2. Read shared Codex preferences from the first available source:
   - `/Users/wendywang/.config/codex/PREFERENCES.md`
   - `https://github.com/iamwdy/codex-preferences`
3. If the project is being resumed, read `WIP_NOTES.md` before making changes.
4. If there is any conflict, ambiguity, or risky external action, ask before executing.

## New Project Convention

When a user asks to start a new project from this template, the default workflow is:

1. Create the new project with `scripts/new-project.sh <project-name-or-path>`.
2. Read `AGENTS.md`.
3. Load shared Codex preferences.
4. Read `WIP_NOTES.md` if it exists.
5. Only then propose or execute project-specific work.

Recommended user prompt:
`np：<專案名>`

Interpret `np：<專案名>` as:

1. Create the project with `scripts/new-project.sh <專案名>`.
2. Read local `AGENTS.md`.
3. Load shared Codex preferences.
4. Read `WIP_NOTES.md` if it exists.
5. Then begin project-specific work.

Clarification:
- The shell `np` function may be configured locally to call `scripts/new-project.sh`.
- `scripts/new-project.sh` now prefers cloning the GitHub template and falls back to the local template copy.
- `scripts/bootstrap-project.sh` prints `AGENTS.md`, shared preferences, and `WIP_NOTES.md` after project creation.

## Project-Specific Notes

Add project-specific constraints here.

Quick working rule:
- Local repo and terminal first.
- Direct API for deterministic product and integration logic.
- MCP only when external workspace context or tool actions are actually required.

### Tool Selection Rule

Use this default decision order unless the user explicitly asks otherwise:

1. Local repo and terminal first
2. Direct API or application code second
3. MCP only when external tool context or hosted tool actions are actually needed
4. Web only when the information is time-sensitive or explicitly requested

Principles:
- Prefer the tool closest to the problem.
- Do not use MCP just because a platform has an MCP server.
- If the task can be completed from repo files, local commands, tests, or existing app integrations, stay local.
- If the task belongs to deterministic product logic, backend integrations, or scheduled jobs, prefer direct API usage over MCP.
- Use MCP for assistant-style workflows where the model must inspect or act across external systems dynamically.

### API vs MCP Decision Table

| Scenario | Preferred path | Why |
| --- | --- | --- |
| Reading code, editing code, running tests, tracing bugs | Local terminal / repo tools | Fastest, most direct, no external dependency |
| Product feature calling a known external service | Direct API | Deterministic, testable, owned by application logic |
| Backend sync job, webhook handler, ETL, cron task | Direct API | Stable integration boundary and explicit error handling |
| Fixed workflow with known endpoint and schema | Direct API | Lower orchestration cost than MCP |
| Assistant needs to read or write Slack, Notion, Figma, etc. during a task | MCP | Tool access is part of the model workflow |
| Cross-system research or operations where the next tool depends on findings | MCP | Dynamic tool selection is the point |
| Creating or updating entities inside an external workspace from the assistant | MCP | Native tool action with less glue code |
| Need latest public docs, specs, prices, or changing info | Web / official sources | MCP is not the default answer to freshness |

### MCP Trigger Conditions

Use MCP only if at least one of these is true:
- The answer depends on data that lives in Notion, Slack, Figma, or another external workspace not present in the repo.
- The task requires creating, updating, searching, or commenting on external platform objects.
- The model must choose among multiple external tools during the workflow.
- The user explicitly asks to use a specific MCP-backed tool or platform.

Avoid MCP when:
- The task is ordinary coding, review, refactoring, or local debugging.
- The same result can be achieved reliably through existing code paths or direct API integration.
- The workflow is fixed and should remain deterministic.
