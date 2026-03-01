# Project Template

## Purpose
Describe the purpose of this project here.

## New Project Flow
1. Create a new folder from `iamwdy/project-template`
2. Read `AGENTS.md`
3. Load shared Codex preferences from the local cache or `https://github.com/iamwdy/codex-preferences`
4. Read `WIP_NOTES.md` if the project is being resumed
5. Run `scripts/bootstrap-project.sh`
6. Replace this README content with project-specific documentation

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
- Use `scripts/bootstrap-project.sh` after cloning the template to prepare local scaffolding

## Recommended Prompt
Use this prompt when starting a new project with Codex:

`np：<專案名>`

Interpretation:
1. Clone `iamwdy/project-template`
2. Read `AGENTS.md`
3. Read shared `codex-preferences`
4. Read `WIP_NOTES.md` if it exists
5. Start project work
