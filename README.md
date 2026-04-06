# Dotfiles

Personal configuration files for my development environment.

## Layout

Automation can copy or symlink entire trees without per-file mapping:

- **`config/`** — XDG-style application configs (Neovim, Ghostty, Zellij, Alacritty, Kitty, Oh My Posh themes, etc.).
- **`home/`** — Dotfiles meant for the home directory (e.g. `.zshrc`, `.bashrc`, `.tmux.conf`, `.vimrc`).

Submodule content (for example Taskwarrior themes) is initialized with `./setup.sh` from this repository root.

## What's Inside

### Terminal & Shell

- **Alacritty** — `config/alacritty/`
- **Ghostty** — `config/ghostty/`
- **Kitty** — `config/kitty/`
- **Zellij** — `config/zellij/`
- **Oh My Posh** — Prompt themes (`config/oh-my-posh/`)

### Editors

- **Neovim** — `config/nvim/` (plugins managed with [lazy.nvim](https://github.com/folke/lazy.nvim))
- **VS Code** — `vs-code/`

### Other

- **Taskwarrior** — `taskwarrior/` (includes a themes submodule)

## Usage

These are my personal configurations. Feel free to browse and adapt them for your own use. Machine-specific settings can live in `~/.local_extras`, which is sourced from `home/.zshrc` and `home/.bashrc` when present.

## License

MIT License — see [LICENSE](./LICENSE) for details.
