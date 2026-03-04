# Project Template

## Purpose
Describe the purpose of this project here.

## New Project Flow
1. Run `scripts/new-project.sh <project-name-or-path>` from this template repository
2. The script will prefer cloning the GitHub template and fall back to the local template copy if remote clone is unavailable
3. The bootstrap step prints `AGENTS.md`, shared Codex preferences, and `WIP_NOTES.md`
4. Replace this README content with project-specific documentation

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

## Template Sync
New repos created from this template include a GitHub Actions workflow at `.github/workflows/template-sync-pr.yml`.

Behavior:
- runs weekly and on manual dispatch
- fetches `iamwdy/project-template`
- syncs only the paths listed in `.github/template-sync-paths.txt`
- opens a PR instead of merging directly

Recommended customization in child repos:
- keep template-owned files such as `AGENTS.md`, `.gitignore`, `.env.example`, and `scripts/` in the sync list
- remove project-specific files such as `README.md` or `WIP_NOTES.md` from the sync list

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
- `np：<專案名>` can be used as a prompt convention for Codex
- If you have a local `np` shell function, it should call `scripts/new-project.sh`
