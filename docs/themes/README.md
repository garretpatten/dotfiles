# UI themes (Gruvbox vs Everforest)

Everything is **Gruvbox dark hard** by default. Everforest assets stay in-repo as alternates you can switch to in a few places.

## One switch (Zsh + Tmux + Oh My Posh)

| Control | Values | Effect |
|--------|--------|--------|
| `home/zsh/theme-env.sh` | `gruvbox` or `everforest` | Sets `DOTFILES_THEME` |

- **Oh My Posh**: `home/zsh/oh-my-posh-theme.zsh` picks `config/oh-my-posh/themes/{gruvbox,everforest}-amro.omp.json`.
- **zsh-syntax-highlighting**: `home/zsh/themes/<theme>-syntax.zsh` (sourced from `home/.zshrc` after OS-specific zsh).
- **Tmux**: `home/.tmux.conf` loads `config/tmux/themes/${DOTFILES_THEME}.conf` (fallback `DOTFILES` from env, `~/.dotfiles_path`, or `$HOME/Projects/dotfiles`). Start tmux **from zsh** so the env is inherited.

Per-session override: `DOTFILES_THEME=everforest zsh`  
Machine-only override (no git edits): add `export DOTFILES_THEME=everforest` to `~/.local_extras`.

## Neovim

Edit **`config/nvim/lua/config/theme.lua`**: return `"gruvbox"` or `"everforest"` (each has `lua/plugins/<name>.lua`). Run `:Lazy sync` after changing.

## Ghostty

Main **`config/ghostty/config`** includes **`theme-gruvbox.inc`** or **`theme-everforest.inc`** (comment/uncomment the `config-file` line).

- Gruvbox uses the custom palette file **`config/ghostty/themes/gruvbox-dark-hard-contrast`** (referenced by name from `theme-gruvbox.inc`).
- Shared options live in **`config/ghostty/core.inc`**.

Copy the whole `config/ghostty/` tree to `~/.config/ghostty/` (or symlink).

## btop

- Themes: `config/btop/themes/gruvbox_dark_hard.theme`, `everforest_dark_hard.theme`
- Set **`color_theme`** in `config/btop/btop.conf` to match the filename (see comment in that file).

## fastfetch

- Active: `config/fastfetch/config.jsonc` (Gruvbox logo colors by default).
- Full alternates: `config/fastfetch/variants/gruvbox.jsonc`, `variants/everforest.jsonc` — copy one over `config.jsonc` to switch.

## Oh My Posh JSON

Both prompts live under **`config/oh-my-posh/themes/`**. Validate with:

```bash
jq -e . < config/oh-my-posh/themes/gruvbox-amro.omp.json
jq -e . < config/oh-my-posh/themes/everforest-amro.omp.json
```

## Tmux layout

- **`config/tmux/includes/base.conf`** — bindings, TPM (no colors).
- **`config/tmux/themes/gruvbox.conf`** / **`everforest.conf`** — status line colors only.
