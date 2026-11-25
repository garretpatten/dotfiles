# OpenCode (AI agent) configuration

<!-- markdownlint-disable MD013 -->

`config/opencode/` holds the global OpenCode configuration (`opencode.jsonc`),
agent instructions (`AGENTS.md`), commands, and skills. On provisioned machines
`~/.config/opencode` is a symlink into this tree.

## MCP servers

Defined under `mcp.servers` in `config/opencode/opencode.jsonc`:

| Server     | Endpoint                                    | Auth         |
| ---------- | ------------------------------------------- | ------------ |
| `calendar` | `https://calendarmcp.googleapis.com/mcp/v1` | Google OAuth |
| `people`   | `https://people.googleapis.com/mcp/v1`      | Google OAuth |
| `tasks`    | `https://tasksmcp.googleapis.com/mcp/v1`    | Google OAuth |
| `notion`   | `https://mcp.notion.com/mcp`                | Notion OAuth |

Google and Notion host these servers; nothing runs locally. The `permissions`
list allows read tools and asks before writes.

## Google OAuth credentials

The three Google servers share one pre-registered OAuth client, referenced
from the environment so no secret is committed:

```jsonc
"client_id": "{env:GOOGLE_OAUTH_CLIENT_ID}",
"client_secret": "{env:GOOGLE_OAUTH_CLIENT_SECRET}",
```

One-time setup on a new machine:

1. In Google Cloud Console → **APIs & Services → Credentials**, create an
   **OAuth 2.0 Client ID** (type _Web application_) with authorized redirect
   URI `http://127.0.0.1:19876/callback` — the port must match `callback_port`
   in the config.
2. Add the credentials to `~/.local_extras` (sourced by `home/.zshrc` and
   `home/.bashrc`; never committed):

   ```sh
   export GOOGLE_OAUTH_CLIENT_ID="…apps.googleusercontent.com"
   export GOOGLE_OAUTH_CLIENT_SECRET="GOCSPX-…"
   ```

3. Restart OpenCode so the background service inherits the variables, then run
   `/mcps` in the TUI and sign in to `calendar`, `people`, and `tasks`. Tokens
   live in OpenCode's local credential store, not in this repo.

If Google returns `401: invalid_client` during sign-in, the running OpenCode
service was started without the variables: run
`source ~/.local_extras && opencode service restart` from a shell that has
them, then retry the sign-in.
