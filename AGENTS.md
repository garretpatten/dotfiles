# Agent instructions

Personal dotfiles: shell startup (`home/`), XDG app configs (`config/`), VS Code
snippets (`vs-code/`), and GitHub Actions CI. Prefer minimal, focused diffs that
match existing style in each touched tree.

## Before you finish

**Do not consider work complete until local checks pass.** CI runs the reusable
[quality-checks](https://github.com/garretpatten/quality-checks) workflow on every
pull request (see `.github/workflows/quality-checks.yaml`). Mirror those linters
locally on files you changed (or on the whole repo when unsure).

1. Install Node dev deps once: `npm ci`
2. Run the relevant commands below (or the full checklist)
3. Fix reported issues; use formatters in **write** mode only when fixing
   Prettier/StyLua output, then re-run **check** mode

### Full local checklist

From the repository root, with common CLI tools installed (`shellcheck`,
`yamllint`, `stylua`, `taplo`, `actionlint` as needed):

```bash
npm ci

npx prettier --check .
npx markdownlint-cli2 "**/*.md" "#node_modules"

yamllint -f standard .github .yamllint

shellcheck home/.bashrc home/.zshrc config/githooks/*

actionlint

stylua --check config/nvim

taplo check config/alacritty/alacritty.toml config/nvim/.stylua.toml

jq -e . < config/nvim/lazy-lock.json
jq -e . < .markdownlint.json
jq -e . < package.json
jq -e . < vs-code/settings.json
jq -e . < .vscode/settings.json
jq -e . < .vscode/extensions.json
```

Run **ESLint**, **Ruff**, and **Hadolint** when you add or edit matching files
(`.js`/`.ts`, `.py`, Dockerfiles). CI enables them but they no-op when no
changed paths match.

### Per-tool reference (matches CI)

- **Prettier** — JS/TS, JSON, CSS, Markdown, YAML (`.prettierrc`, `.prettierignore`).
  Check: `npx prettier --check .` — Fix: `npx prettier --write .`
- **markdownlint-cli2** — `**/*.md`. Check:
  `npx markdownlint-cli2 "**/*.md" "#node_modules"` — Fix manually (`.markdownlint.json`)
- **yamllint** — `.yml`/`.yaml`. Check: `yamllint -f standard .github .yamllint`
- **ShellCheck** — `home/.bashrc`, `home/.zshrc`, `config/githooks/*`. Check:
  `shellcheck home/.bashrc home/.zshrc config/githooks/*` — Keep
  `# shellcheck` directives when intentional
- **actionlint** — `.github/workflows/`, `.github/actions/`. Check: `actionlint`
- **StyLua** — `config/nvim/**/*.lua`. Check: `stylua --check config/nvim` — Fix:
  `stylua config/nvim`
- **Taplo** — `*.toml`. Check: `taplo check <paths>` — Fix: `taplo fmt <paths>`
- **jq** — `*.json` syntax. Check: `jq -e . < file.json`
- **ESLint** — JS/TS when present. Check: `npx eslint <paths>` — Fix:
  `npx eslint --fix <paths>`
- **Ruff** — Python when present. Check: `ruff check <paths>` — Fix:
  `ruff check --fix <paths>`
- **Hadolint** — Dockerfiles when present. Check: `hadolint <Dockerfile>`

PR workflows only lint **changed** files; when editing locally, still run the
tools for the file types you touched so CI does not fail on unrelated paths.

## Repository layout

- **`config/`** — XDG configs (Neovim, terminals, themes). Neovim Lua lives under
  `config/nvim/`; format with StyLua.
- **`home/`** — Dotfiles synced to `$HOME` (`.zshrc`, `.bashrc`, `.tmux.conf`,
  etc.). OS-specific zsh snippets: `home/zsh/{darwin,arch,fedora,ubuntu}.zsh`.
- **`setup.sh`** — Bootstrap: validates **`config/`** and **`home/`**,
  optional git submodules if **`.gitmodules`** exists, headless **`nvim`** for
  Lazy/Tree-sitter. **`./setup.sh --link-xdg-config`** symlinks each
  **`config/<app>/`** directory to **`$XDG_CONFIG_HOME`** (see **`README.md`**).
- **`vs-code/`** — Editor settings reference (not always symlinked).

`home/.zshrc` defines `DOTFILES` via `~/.dotfiles_path` and exports XDG defaults.
Secrets belong in `~/.local_extras`, not in this repo.

## Embedding as a submodule (consumers)

When this repo lives under another project (nested path such as **`src/dotfiles`**):

- **`DOTFILES` must be the nested checkout**, not the parent repo root — typically
  via **`~/.dotfiles_path`**, **`export DOTFILES`** in **`~/.local_extras`**, or
  discovery defaults.
- **Two-step Git workflow**: Commit here, push submodule remote, then bump the
  submodule pointer + commit in the parent repository.
- **Provisioning**: Parent orchestration often **copies only some** **`config/`**
  subtrees; **`setup.sh --link-xdg-config`** run **from this repo’s directory**
  (works inside the submodule checkout) installs the **full** XDG symlink layout.
  Modular **`home/.tmux.conf`** that **`source-file`s `~/.config/tmux`** requires
  **`config/tmux`** under **`~/.config`** unless **`home/.tmux.conf`** is older
  self-contained inline config.
- **Lint/devdeps**: **`npm ci`** applies to **this** tree’s **`package.json`**;
  the parent project’s **`npm`** install does not substitute unless documented
  otherwise.

## Conventions

- **Shell**: bash-compatible snippets in zsh files use `# shellcheck shell=bash`
  where needed. Match existing alias and comment style in `home/.zshrc`.
- **Markdown**: 2-space list indent (`.markdownlint.json` MD007). First-line H1
  headings in README-style docs; GitHub templates may disable MD041 via HTML
  comments.
- **YAML**: 80-column line length in workflows unless a `yamllint disable-line`
  comment is already used for long `uses:` URLs.
- **Lua (Neovim)**: 2 spaces, 100 columns (`.stylua.toml` in `config/nvim/`).
- **Commits**: Only when the user asks. Do not commit secrets (tokens, `pass`
  paths with real credentials).

## CI beyond linters

- **Quality**: `.github/workflows/quality-checks.yaml` — all linters listed above
  (`stylua_run`, `shellcheck_run`, etc.).
- **Security**: `.github/workflows/security-checks.yaml` — Semgrep and TruffleHog
  on pull requests. Avoid adding secrets or high-risk patterns.

## Useful aliases (from `home/.zshrc`)

If the user’s environment sources this repo’s `home/.zshrc`:

- `mdlint` — markdownlint-cli2 on Markdown
- `prettier` — `npx prettier --write .` (prefer `--check` before opening a PR)
