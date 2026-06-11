# Dotfiles

<img src="docs/assets/dotfiles-mark.svg" alt="" width="88" height="88">

**Personal, portable developer environment** — shell startup, XDG app configs,
editors, terminals, and CI-backed quality checks. Designed to symlink or vend
across machines (including nested submodule layouts) without one-off paths baked
into the tree.

[![MIT License](https://img.shields.io/github/license/garretpatten/dotfiles?style=flat-square&label=license&color=458588)](./LICENSE)
[![Quality checks](https://img.shields.io/github/actions/workflow/status/garretpatten/dotfiles/quality-checks.yaml?branch=master&style=flat-square&label=quality&logo=github)](https://github.com/garretpatten/dotfiles/actions/workflows/quality-checks.yaml)
[![Security checks](https://img.shields.io/github/actions/workflow/status/garretpatten/dotfiles/security-checks.yaml?branch=master&style=flat-square&label=security&logo=github)](https://github.com/garretpatten/dotfiles/actions/workflows/security-checks.yaml)
[![OpenSSF Scorecard](https://img.shields.io/badge/OpenSSF-Scorecard-101828?style=flat-square&logo=openssf)](https://securityscorecards.dev/viewer/?uri=github.com/garretpatten/dotfiles)
[![Last commit](https://img.shields.io/github/last-commit/garretpatten/dotfiles?style=flat-square&label=updated)](https://github.com/garretpatten/dotfiles/commits/master/)

## Layout

Automation can copy or symlink entire trees without per-file mapping:

- **`config/`** — XDG-style application configs (Neovim, Ghostty, Zellij,
  Alacritty, Kitty, Oh My Posh themes, etc.). Paths inside these files avoid
  machine-specific locations where possible (e.g. Neovim uses `stdpath()` for
  cache/state; Alacritty theme imports use `$HOME/.config/...`).
- **`home/`** — Dotfiles meant for the home directory (e.g. `.zshrc`,
  `.bashrc`, `.tmux.conf`, `.vimrc`). Tmux 3.1+ can use
  `~/.config/tmux/tmux.conf`; this repo still ships **`~/.tmux.conf`** for
  broad compatibility.

### XDG directories

`home/.zshrc` exports standard defaults when unset (XDG Base Directory spec):

| Variable          | Default              |
| ----------------- | -------------------- |
| `XDG_CONFIG_HOME` | `$HOME/.config`      |
| `XDG_DATA_HOME`   | `$HOME/.local/share` |
| `XDG_CACHE_HOME`  | `$HOME/.cache`       |
| `XDG_STATE_HOME`  | `$HOME/.local/state` |

Tools that respect these (including many terminals and Neovim) can find configs
under `~/.config` without littering `$HOME`.

## Embedding as a submodule (or vendored copy)

Some projects ship this repo under a nested path (for example
**`src/dotfiles/`** in [macOS-setup-scripts]). In that layout, keep these in mind:

[macOS-setup-scripts]: https://github.com/garretpatten/macOS-setup-scripts

- **OS-specific zsh snippets** live in **`config/zsh/`** and are picked up
  automatically once **`~/.config/zsh`** is symlinked by the provisioning scripts.
  No path variables need to point at the repo root.
- **Two Git histories**: Changes land in **this** repository first. The parent then
  records the new submodule commit with **`git add <submodule-path>`** and its own
  commit. **`git submodule update --init`** (or **`--remote`**) only fetches what
  the parent has pinned.
- **Parent scripts may copy a subset of `config/`**. For example, one phase might
  install terminals and another Neovim; that is not always the full **`config/`**
  tree. Setup and provisioning scripts live in the parent repository (e.g.
  [macOS-setup-scripts]); this repo contains only configs, not scripts.

- **Node tooling for this repo** (Prettier, markdownlint, etc.) uses
  **`package.json` here**. A parent project’s **`npm ci`** at its own root does
  not replace **`(cd path/to/dotfiles && npm ci)`** when you lint or develop
  **inside** the dotfiles tree.

## CI and supply chain

Pull requests run reusable workflows for **linting / formatting** (StyLua,
ShellCheck, Prettier, and the rest of the shared quality matrix) and **security**
(Semgrep, TruffleHog). **Dependabot** keeps GitHub Actions references current.
Contribution and automation notes for agents live in [`AGENTS.md`](./AGENTS.md).

## What's inside

### Terminal & Shell

- **Alacritty** — `config/alacritty/`
- **Ghostty** — `config/ghostty/`
- **Kitty** — `config/kitty/`
- **Zellij** — `config/zellij/`
- **Oh My Posh** — Prompt themes (`config/oh-my-posh/`)

### Editors

- **Neovim** — `config/nvim/`; plugins via
  [lazy.nvim](https://github.com/folke/lazy.nvim). Options live in
  **`lua/config/lazy.lua`** (`install.missing = true`,
  `change_detection.enabled = false` for non-interrupting installs and
  automation). **`lazy-lock.json`** is committed so plugin revisions match across
  machines. Example headless sync:
  `XDG_CONFIG_HOME=/path/to/this/repo/config nvim --headless "+Lazy! sync" +qa`
- **VS Code** — `vs-code/`

### Other

- **Taskwarrior** — `taskwarrior/` (includes a themes submodule)

## Usage

These are my personal configurations. Feel free to browse and adapt them for your
own use. Machine-specific settings can live in `~/.local_extras`, which is sourced
from `home/.zshrc` and `home/.bashrc` when present.

## License

MIT License — see [LICENSE](./LICENSE) for details.
