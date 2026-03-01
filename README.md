# Project Template

## Purpose
Describe the purpose of this project here.

## New Project Flow
1. Run `scripts/new-project.sh <project-name-or-path>` from this template repository
2. Read `AGENTS.md` in the new project
3. Load shared Codex preferences from the local cache or `https://github.com/iamwdy/codex-preferences`
4. Read `WIP_NOTES.md` if the project is being resumed
5. Replace this README content with project-specific documentation

## Setup
1. Copy `.env.example` to `.env`
2. Fill in only the variables needed for this project
3. Install dependencies
4. Run the project

## Conventions
- Project-specific agent guidance lives in `AGENTS.md`
- Shared Codex collaboration preferences should come from the `codex-preferences` repository (`https://github.com/iamwdy/codex-preferences`)
- A local machine-specific copy may also exist at `/Users/wendywang/.config/codex/PREFERENCES.md`
- If work is paused mid-development, create `WIP_NOTES.md` to capture status and next steps
- Use `scripts/new-project.sh` to create a new project from this template
- `scripts/bootstrap-project.sh` prepares the local preference cache placeholder and `WIP_NOTES.md` inside an existing project

## Recommended Prompt
Use this prompt when starting a new project with Codex:

`np：<專案名>`

Interpretation:
1. Create the project with `scripts/new-project.sh <專案名>`
2. Read `AGENTS.md`
3. Read shared `codex-preferences`
4. Read `WIP_NOTES.md` if it exists
5. Start project work

Important:
- `np：<專案名>` is a prompt convention, not a built-in shell command
- If you want a real `np` terminal command, create a shell alias or function that calls `scripts/new-project.sh`
