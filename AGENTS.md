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

shellcheck setup.sh home/.bashrc home/.zshrc home/zsh/*.zsh home/zsh/themes/*.zsh

stylua --check config/nvim

taplo check config/alacritty/alacritty.toml config/nvim/.stylua.toml

jq -e . < config/oh-my-posh/themes/gruvbox-amro.omp.json
jq -e . < config/oh-my-posh/themes/everforest-amro.omp.json
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
- **ShellCheck** — `setup.sh`, `home/.bashrc`, `home/.zshrc`, `home/zsh/*.zsh`,
  `home/zsh/themes/*.zsh`. Check: `shellcheck setup.sh home/.bashrc home/.zshrc home/zsh/*.zsh home/zsh/themes/*.zsh` — Keep
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
  **`home/zsh/theme-env.sh`** sets **`DOTFILES_THEME`**; it defaults to **`gruvbox`**
  so no edit is required for the Gruvbox stack. **Tmux** enables **`mouse on`** in
  **`config/tmux/includes/base.conf`** so Ghostty trackpad scroll works with zsh
  (see **`docs/themes/README.md`**).
- **`setup.sh`** — Bootstrap: validates `config/` and `home/`, submodules, headless
  `nvim` for Lazy/Tree-sitter.
- **`vs-code/`** — Editor settings reference (not always symlinked).

`home/.zshrc` defines `DOTFILES` via `~/.dotfiles_path` and exports XDG defaults.
Secrets belong in `~/.local_extras`, not in this repo.

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
