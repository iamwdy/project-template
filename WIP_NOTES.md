# WIP Notes

## Current Status
- Codex global MCP config was updated so `asana` now points directly to `https://mcp.asana.com/v2/mcp` using native HTTP transport.
- Confirmed the previous `stdio` wrapper via `npx mcp-remote@latest ...` was incompatible with `codex mcp login asana` because OAuth login there only supports streamable HTTP servers.
- Confirmed `codex mcp get asana` now shows `transport: streamable_http`.
- Confirmed Asana MCP login succeeded after switching to the native HTTP MCP config.
- Codex global MCP config was updated so `slack` now points to `https://mcp.slack.com/mcp`.
- Slack MCP auth was switched from unsupported CLI OAuth login to bearer-token env var mode using `SLACK_MCP_TOKEN`.
- Verified that `codex mcp login slack` does not work for Slack MCP because Slack does not support dynamic client registration in this flow.
- Added a minimal local Slack OAuth callback server at `scripts/slack-oauth-callback.js` listening on `127.0.0.1:3000`.
- A temporary HTTPS redirect URL was re-created via ngrok for Slack OAuth:
  `https://4a80-118-163-7-135.ngrok-free.app/slack/oauth/callback`
- User provided Slack app `Client ID` (`5129026775.9149465820692`) and completed OAuth token exchange successfully.
- Confirmed the app is using User Token Scopes, not Bot Token Scopes.
- Confirmed `codex mcp list` shows:
  `slack   https://mcp.slack.com/mcp   SLACK_MCP_TOKEN   enabled   Bearer token`
- Slack MCP end-to-end connectivity is not yet verified from this Codex session because `SLACK_MCP_TOKEN` was not present in the agent process environment (`SLACK_MCP_TOKEN_MISSING`).
- Added a tool-selection policy to `AGENTS.md` for this template copy:
  local repo first, direct API for deterministic integrations, MCP only when external workspace context or hosted tool actions are required.
- Added an `API vs MCP` decision table and MCP trigger conditions to make future tool usage consistent across new projects.

## Next Steps
- Sync the `AGENTS.md` tool-selection policy into the actual `project-template` git repository and push it upstream.
- Validate actual Asana tool calls from a fresh Codex session to confirm end-to-end connectivity beyond login.
- In the same shell used to launch Codex, run:
  `read -s SLACK_MCP_TOKEN`
  then `export SLACK_MCP_TOKEN`
- Re-launch `codex` from that same shell so the agent process inherits the token.
- Validate Slack MCP connectivity from Codex after the token is present in-process.

## Risks / Open Questions
- Asana MCP should remain configured as native HTTP; reverting it to `stdio` via `mcp-remote` will break `codex mcp login asana` again.
- Slack MCP requires a user token flow and does not work with `codex mcp login slack` dynamic registration.
- Slack MCP may require the app to be an internal app or otherwise satisfy Slack MCP eligibility rules.
- Redirect URL must match exactly across Slack app settings, authorize URL, and token exchange request.
- The current ngrok URL is ephemeral and will stop working once the ngrok session ends; if that happens, Slack app settings and authorize requests must be updated again.
- Do not paste or store Slack tokens in chat, repo files, or `~/.codex/config.toml`.
- The local `workflow` directory is not itself a git repo, so template changes must be propagated through the real `project-template` repository before they can be committed and pushed.
