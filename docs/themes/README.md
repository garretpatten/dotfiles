# UI themes (Gruvbox vs Everforest)

<!-- markdownlint-disable MD013 -->

If you **do not change anything**, you get **Gruvbox dark hard** consistently:
`DOTFILES_THEME` defaults in **`home/zsh/theme-env.sh`** (sourced from **`home/.zshrc`**),
Neovim **`config/nvim/lua/config/theme.lua`**, Ghostty uses **`themes/gruvbox-dark-hard-contrast`**,
Oh My Posh **`gruvbox-amro`**, Zellij **`gruvbox-dark`**, btop, tmux Gruvbox status (**`config/tmux/themes/gruvbox.conf`**),
Fastfetch accents, VS Code Gruvbox in **`vs-code/`**.

Everforest assets stay in-repo as alternates; switch only when you want to.

Everything below assumes you might override **`DOTFILES_THEME`** or individual app configs.

| Control                 | Values                    | Effect                |
| ----------------------- | ------------------------- | --------------------- |
| `home/zsh/theme-env.sh` | `gruvbox` or `everforest` | Sets `DOTFILES_THEME` |

- **Oh My Posh**: **`home/zsh/oh-my-posh-theme.zsh`** (sourced from **`home/zsh/{darwin,arch,fedora,ubuntu}.zsh`**) picks `config/oh-my-posh/themes/{gruvbox,everforest}-amro.omp.json`.
- **zsh-syntax-highlighting**: optional **`home/zsh/themes/<theme>-syntax.zsh`** — not wired by default; Gruvbox colors are set inline in **`home/.zshrc`**.
- **Tmux**: **`home/.tmux.conf`** sources **`~/.config/tmux/includes/base.conf`**, which loads **`~/.config/tmux/themes/gruvbox.conf`**. Run **`setup.sh --link-xdg-config`** so **`~/.config/tmux`** points at **`config/tmux/`**.
  Per-session override: `DOTFILES_THEME=everforest zsh`  
  Machine-only override (no git edits): add `export DOTFILES_THEME=everforest` to `~/.local_extras`.

## Neovim

Edit **`config/nvim/lua/config/theme.lua`**: return `"gruvbox"` or `"everforest"` (each has `lua/plugins/<name>.lua`). Run `:Lazy sync` after changing.

## Ghostty

### Touchpad scroll vs shell history (with tmux)

On macOS, **Ghostty** maps two-finger scroll to **arrow keys** when the app is in the **alternate screen** and the running program has **not** enabled mouse reporting (see [Ghostty discussion #4617](https://github.com/orgs/ghostty-org/discussions/4617)). **zsh** often binds `^[[A` / `^[[B` to **history search**, so scrolling feels like “command history” instead of **scrollback**.

**Fix (used here):** `set -g mouse on` in tmux (`config/tmux/includes/base.conf`) so tmux captures wheel events. Reload: `prefix` + `r`.

### Theme files

Primary **`config/ghostty/config`** sets **`theme = gruvbox-dark-hard-contrast`** (palette **`themes/gruvbox-dark-hard-contrast`**).
Optional snippets **`theme-gruvbox.inc`**, **`theme-everforest.inc`**, and **`core.inc`** duplicate settings for alternate split layouts — the single-file **`config`** in this repo is canonical.

Symlink **`config/ghostty/`** to **`~/.config/ghostty/`** (e.g. via **`setup.sh --link-xdg-config`**).

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
