# Dotfiles

Personal configuration files for my development environment.

## Layout

Automation can copy or symlink entire trees without per-file mapping:

- **`config/`** — XDG-style application configs (Neovim, Ghostty, Zellij, Alacritty, Kitty, Oh My Posh themes, etc.). Paths inside these files avoid machine-specific locations where possible (e.g. Neovim uses `stdpath()` for cache/state; Alacritty theme imports use `$HOME/.config/...`).
- **`home/`** — Dotfiles meant for the home directory (e.g. `.zshrc`, `.bashrc`, `.tmux.conf`, `.vimrc`). OS-specific zsh snippets live under **`home/zsh/`** and are sourced from **`home/.zshrc`** after resolving the repo root. Tmux 3.1+ can use `~/.config/tmux/tmux.conf`; this repo still ships **`~/.tmux.conf`** for broad compatibility.

### `DOTFILES` and shell startup

`home/.zshrc` sets **`DOTFILES`** to the repository root by:

1. Reading **`~/.dotfiles_path`** if it exists and still points at a tree that contains `home/zsh/`, or
2. Searching a few common locations once, then writing the result to **`~/.dotfiles_path`** so the next login avoids repeated filesystem checks.

Override **`DOTFILES`** in **`~/.local_extras`** if your clone lives somewhere else.

### XDG directories

`home/.zshrc` exports standard defaults when unset (XDG Base Directory spec):

| Variable | Default |
|----------|---------|
| `XDG_CONFIG_HOME` | `$HOME/.config` |
| `XDG_DATA_HOME` | `$HOME/.local/share` |
| `XDG_CACHE_HOME` | `$HOME/.cache` |
| `XDG_STATE_HOME` | `$HOME/.local/state` |

Tools that respect these (including many terminals and Neovim) can find configs under `~/.config` without littering `$HOME`.

## Setup script

From the repository root, **`./setup.sh`**:

- Verifies **`config/`** and **`home/`** exist before doing anything.
- If **`.gitmodules`** is present, runs **`git submodule update --init --recursive`** only when submodules are not yet initialized; otherwise **`git submodule update --recursive`**. Safe to run repeatedly.

## CI

GitHub Actions runs **StyLua** on `config/nvim` and **ShellCheck** on **`setup.sh`** and **`home/zsh/*.zsh`**.

## What's Inside

### Terminal & Shell

- **Alacritty** — `config/alacritty/`
- **Ghostty** — `config/ghostty/`
- **Kitty** — `config/kitty/`
- **Zellij** — `config/zellij/`
- **Oh My Posh** — Prompt themes (`config/oh-my-posh/`)

### Editors

- **Neovim** — `config/nvim/`; plugins via [lazy.nvim](https://github.com/folke/lazy.nvim). Options live in **`lua/config/lazy.lua`** (`install.missing = true`, `change_detection.enabled = false` for non-interrupting installs and automation). **`lazy-lock.json`** is committed so plugin revisions match across machines. Example headless sync:  
  `XDG_CONFIG_HOME=/path/to/this/repo/config nvim --headless "+Lazy! sync" +qa`
- **VS Code** — `vs-code/`

### Other

- **Taskwarrior** — `taskwarrior/` (includes a themes submodule)

## Usage

These are my personal configurations. Feel free to browse and adapt them for your own use. Machine-specific settings can live in `~/.local_extras`, which is sourced from `home/.zshrc` and `home/.bashrc` when present.

## License

MIT License — see [LICENSE](./LICENSE) for details.
