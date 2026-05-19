# UI themes (Gruvbox vs Everforest)

<!-- markdownlint-disable MD013 -->

If you **do not change anything**, you get **Gruvbox dark hard** consistently:
`DOTFILES_THEME` defaults in **`home/zsh/theme-env.sh`**, Neovim **`config/nvim/lua/config/theme.lua`**, Ghostty **`theme-gruvbox.inc`**, btop, fastfetch, and tmux’s Gruvbox status theme.

Everforest assets stay in-repo as alternates; switch only when you want to.

Everything below assumes you might override **`DOTFILES_THEME`** or individual app configs.

| Control                 | Values                    | Effect                |
| ----------------------- | ------------------------- | --------------------- |
| `home/zsh/theme-env.sh` | `gruvbox` or `everforest` | Sets `DOTFILES_THEME` |

- **Oh My Posh**: `home/zsh/oh-my-posh-theme.zsh` picks `config/oh-my-posh/themes/{gruvbox,everforest}-amro.omp.json`.
- **zsh-syntax-highlighting**: `home/zsh/themes/<theme>-syntax.zsh` (sourced from `home/.zshrc` after OS-specific zsh).
- **Tmux**: `home/.tmux.conf` loads `config/tmux/themes/${DOTFILES_THEME}.conf` (fallback `DOTFILES` from env, `~/.dotfiles_path`, or `$HOME/Projects/dotfiles`). Start tmux **from zsh** so the env is inherited.

Per-session override: `DOTFILES_THEME=everforest zsh`  
Machine-only override (no git edits): add `export DOTFILES_THEME=everforest` to `~/.local_extras`.

## Neovim

Edit **`config/nvim/lua/config/theme.lua`**: return `"gruvbox"` or `"everforest"` (each has `lua/plugins/<name>.lua`). Run `:Lazy sync` after changing.

## Ghostty

### Touchpad scroll vs shell history (with tmux)

On macOS, **Ghostty** maps two-finger scroll to **arrow keys** when the app is in the **alternate screen** and the running program has **not** enabled mouse reporting (see [Ghostty discussion #4617](https://github.com/orgs/ghostty-org/discussions/4617)). **zsh** often binds `^[[A` / `^[[B` to **history search**, so scrolling feels like “command history” instead of **scrollback**.

**Fix (used here):** `set -g mouse on` in tmux (`config/tmux/includes/base.conf`) so tmux captures wheel events. Reload: `prefix` + `r`.

### Theme files

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

- **`config/tmux/includes/base.conf`** — bindings, mouse (**`mouse on`** for Ghostty scroll — see **Ghostty** above), TPM.
- **`config/tmux/themes/gruvbox.conf`** / **`everforest.conf`** — status line colors only.
