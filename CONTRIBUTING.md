# Contributing

Participants are expected to follow the
[Code of Conduct](./CODE_OF_CONDUCT.md).

## Issues

Security vulnerabilities are **not** tracked in public issues until
addressed; see **[SECURITY.md](./SECURITY.md)**.

Use [GitHub Issues](https://github.com/garretpatten/dotfiles/issues) with
the **Bug report** or **Feature request** form. Include OS and version,
desktop environment, and the `config/`, `home/`, or `vs-code/` path
involved (redact private paths and secrets).

## Pull requests

- Branch from **`master`**, focused scope per PR.
- Prefer portable paths; avoid machine-specific locations in tracked
  files.
- Secrets and machine-specific credentials belong in
  **`~/.local_extras`**, not in this repository (see
  [README.md](./README.md) and [SECURITY.md](./SECURITY.md)).
- This repo is often consumed as a submodule (for example
  **`src/dotfiles`** in the setup-script repositories). Land changes
  here first; parent repos bump the submodule pointer in a separate
  commit.

### Checks (from repo root)

```bash
npm ci

npx prettier --check .
npx markdownlint-cli2 "**/*.md" "#node_modules"

yamllint -f standard .github .yamllint
```

Documentation and template changes still need a clean **Prettier**,
**markdownlint**, and **yamllint** run. When you change shell, Lua,
TOML, JSON, or workflow files, also run the matching tools from
[`AGENTS.md`](./AGENTS.md) (ShellCheck, StyLua, Taplo, jq, actionlint).

Keep YAML within **`.yamllint`** (80-character lines unless an existing
waiver applies).
