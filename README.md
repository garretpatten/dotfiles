# Dotfiles

Personal configuration files for my development environment.

## Layout

Automation can copy or symlink entire trees without per-file mapping:

- **`config/`** — XDG-style application configs (Neovim, Ghostty, Zellij,
  Alacritty, Kitty, Oh My Posh themes, etc.). Paths inside these files avoid
  machine-specific locations where possible (e.g. Neovim uses `stdpath()` for
  cache/state; Alacritty theme imports use `$HOME/.config/...`).
- **`home/`** — Dotfiles meant for the home directory (e.g. `.zshrc`,
  `.bashrc`, `.tmux.conf`, `.vimrc`). OS-specific zsh snippets live under
  **`home/zsh/`** and are sourced from **`home/.zshrc`** after resolving the
  repo root. Tmux 3.1+ can use `~/.config/tmux/tmux.conf`; this repo still ships
  **`~/.tmux.conf`** for broad compatibility.

### `DOTFILES` and shell startup

`home/.zshrc` sets **`DOTFILES`** to the repository root by:

1. Reading **`~/.dotfiles_path`** if it exists and still points at a tree that
   contains `home/zsh/`, or
2. Searching a few common locations once, then writing the result to
   **`~/.dotfiles_path`** so the next login avoids repeated filesystem checks.

Override **`DOTFILES`** in **`~/.local_extras`** if your clone lives somewhere
else.

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

## Setup script

From the repository root:

- **`./setup.sh`** — verifies **`config/`** and **`home/`**, runs git submodule
  helpers when **`.gitmodules`** exists (safe to rerun), then runs optional
  headless Neovim **Lazy**/Tree-sitter steps when **`nvim`** is on `PATH`.

- **`./setup.sh --link-xdg-config`** — symlinks every **`config/<app>/`**
  tree to **`$XDG_CONFIG_HOME/<app>/`** (default **`~/.config/<app>/`**). If you
  already have a **real directory** there, it is renamed to
  **`*.dotfiles-bak-<timestamp>`** first.

After linking: **Ghostty**, **Kitty**, **Neovim**, **tmux** module layout, etc.
resolve against **`~/.config`**. **`home/.tmux.conf`** assumes
**`~/.config/tmux/includes/base.conf`** exists.

## Embedding as a submodule (or vendored copy)

Some projects ship this repo under a nested path (for example
**`src/dotfiles/`** in [macOS-setup-scripts]). In that layout, keep these in mind:

[macOS-setup-scripts]: https://github.com/garretpatten/macOS-setup-scripts

- **`DOTFILES` is the dotfiles checkout root**, not the parent repository. Your
  shell resolves it via **`~/.dotfiles_path`** (often written by parent
  provisioning scripts), auto-discovery under **`~/Projects/dotfiles`**, or
  **`export DOTFILES=…`** in **`~/.local_extras`**. If you move from a submodule
  path to a standalone clone, refresh **`~/.dotfiles_path`** or **`DOTFILES`**.
- **Two Git histories**: Changes land in **this** repository first. The parent then
  records the new submodule commit with **`git add <submodule-path>`** and its own
  commit. **`git submodule update --init`** (or **`--remote`**) only fetches what
  the parent has pinned.
- **Parent scripts may copy a subset of `config/`**. For example, one phase might
  install terminals and another Neovim; that is not always the full **`config/`**
  tree. To mirror **everything** under **`~/.config/<app>/`**, run from **this**
  repo (submodule directory is fine):

  ```bash
  ./setup.sh --link-xdg-config
  ```

  That is especially relevant if **`home/.tmux.conf`** uses the modular loader
  (**`source-file ~/.config/tmux/...`**) — you need **`config/tmux/`** present
  under **`~/.config/tmux`** (symlink or copy). Older **inline-only** **`home/.tmux.conf`**
  files self-contained without **`~/.config/tmux`** are an exception.

- **Node tooling for this repo** (Prettier, markdownlint, etc.) uses
  **`package.json` here**. A parent project’s **`npm ci`** at its own root does
  not replace **`(cd path/to/dotfiles && npm ci)`** when you lint or develop
  **inside** the dotfiles tree.

## CI

GitHub Actions runs **StyLua** on `config/nvim` and **ShellCheck** on
**`setup.sh`** and **`home/zsh/*.zsh`**.

## What's Inside

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
