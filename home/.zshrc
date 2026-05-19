# shellcheck shell=bash
### XDG base dirs (defaults per spec; tools honor these in config files)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

### Dotfiles root (override in ~/.local_extras if your clone lives elsewhere)
if [[ -z "${DOTFILES:-}" ]]; then
  _df_cache="$HOME/.dotfiles_path"
  if [[ -f "$_df_cache" ]]; then
    IFS= read -r _cached < "$_df_cache" || true
    if [[ -n "${_cached:-}" && -d "$_cached/home/zsh" ]]; then
      DOTFILES="$_cached"
    fi
  fi
  if [[ -z "${DOTFILES:-}" ]]; then
    for _df in "$HOME/.config/dotfiles" "$HOME/Projects/dotfiles" "$HOME/dotfiles"; do
      if [[ -d "$_df/home/zsh" ]]; then
        DOTFILES="$_df"
        printf '%s\n' "$DOTFILES" > "$_df_cache"
        break
      fi
    done
  fi
  unset _df_cache _cached _df
fi
export DOTFILES

### Default UI theme (Gruvbox dark hard; override with DOTFILES_THEME / ~/.local_extras)
if [[ -n "${DOTFILES:-}" && -r "$DOTFILES/home/zsh/theme-env.sh" ]]; then
  # Dynamic path prevents shellcheck following; file is bundled in home/zsh/theme-env.sh
  # shellcheck disable=SC1091
  . "$DOTFILES/home/zsh/theme-env.sh"
fi

### Cursor / VS Code integrated terminal (alternate-screen leak → wheel mimics arrows)
# When the tty is stuck in alternate-screen semantics, the wheel sends ^[[A/B;
# home/.zshrc maps those to history search. Leave alt screen before each prompt.
# Opt out: DISABLE_DOTFILES_VSCODE_ALTSCR_FIX=1
if [[ "${TERM_PROGRAM:-}" == vscode && -z "${DISABLE_DOTFILES_VSCODE_ALTSCR_FIX:-}" ]]; then
  _dotfiles_precmd_vscode_leave_alt_scr() {
    [[ -t 1 ]] || return 0
    printf '\033[?1049l'
  }
  # zsh precmd_functions; harmless if empty (POSIX bash array syntax parses under shellcheck).
  precmd_functions+=(_dotfiles_precmd_vscode_leave_alt_scr)
fi

### OS-specific plugins, update aliases, and theme examples — see home/zsh/*.zsh
if [[ -n "${DOTFILES:-}" ]]; then
  case "$(uname -s)" in
    Darwin)
      # shellcheck source=/dev/null
      [[ -f "$DOTFILES/home/zsh/darwin.zsh" ]] && source "$DOTFILES/home/zsh/darwin.zsh"
      ;;
    Linux)
      if [[ -r /etc/os-release ]]; then
        # shellcheck source=/dev/null
        . /etc/os-release
        case "${ID:-}" in
          debian | ubuntu | linuxmint)
            # shellcheck source=/dev/null
            [[ -f "$DOTFILES/home/zsh/ubuntu.zsh" ]] && source "$DOTFILES/home/zsh/ubuntu.zsh"
            ;;
          arch | archlinux)
            # shellcheck source=/dev/null
            [[ -f "$DOTFILES/home/zsh/arch.zsh" ]] && source "$DOTFILES/home/zsh/arch.zsh"
            ;;
          fedora)
            # shellcheck source=/dev/null
            [[ -f "$DOTFILES/home/zsh/fedora.zsh" ]] && source "$DOTFILES/home/zsh/fedora.zsh"
            ;;
        esac
      fi
      ;;
  esac
fi

# Highlighting colors aligned with Gruvbox Dark Hard (TerminalColors). Keys are
# consumed by zsh-syntax-highlighting (not Bash variable names despite SC2154).
# shellcheck disable=SC2154,SC2034
ZSH_HIGHLIGHT_STYLES[command]='fg=#b8bb26,bold'
# shellcheck disable=SC2154
ZSH_HIGHLIGHT_STYLES[alias]='fg=#b8bb26,bold'
# shellcheck disable=SC2154
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebdbb2'
# shellcheck disable=SC2154,SC2034
ZSH_HIGHLIGHT_STYLES[error]='fg=#fb4934,underline'

### Paths ###
#
# LM Studio CLI
export PATH="$PATH:$HOME/.lmstudio/bin"
#
# Proton Pass CLI
export PATH="$HOME/.local/bin:$PATH"

### Aliases ###
#
# Development
alias acp='git add . && git commit -m "chore: make some updates" && git push origin'
alias sub="git submodule init && git submodule update --remote --recursive"
alias ups="git submodule update --remote --recursive && git add . && git commit -m 'Update submodules' && git push origin"
#
# System
alias cbg='bash "$HOME/Projects/system-scripts/code-backup/code-backup-gitlab.sh"'
alias cbl='bash "$HOME/Projects/system-scripts/code-backup/code-backup-local.sh"'
alias ff="fastfetch"
alias fp="ps aux | grep"
alias jfc="pbpaste | jq . | pbcopy"
alias home="cd && clear && echo '' && fastfetch && ls"
alias kanye="curl -s https://api.kanye.rest | jq '.quote'"
alias ls="eza --color=always --icons=always"
alias lls="eza -la"
alias mdlint='npx markdownlint-cli2 "**/*.md" "#node_modules"'
alias neo="clear && echo '' && fastfetch"
alias prettier="npx prettier --write ."
alias scan="sudo freshclam && sudo clamscan -i -r"
alias status="protonvpn-cli status"
alias ts='bash "$HOME/Projects/tmux-scripts/tmux-setup.sh"'
alias vpn="protonvpn-cli connect"

### Environment Variables ###
#
# GitHub
GITHUB_TOKEN=$(pass-cli item view pass://Personal/'GitHub Token (Personal)'/token)
export GITHUB_TOKEN
# Other secrets: set in ~/.local_extras (not committed).
#
# Nvim
export NVIM=nvim
export EDITOR="$NVIM"
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# shellcheck disable=SC1091
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### History Setup ###
#
HISTFILE=$HOME/.zhistory
# shellcheck disable=SC2034
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# shellcheck source=/dev/null
[[ -f ~/.local_extras ]] && source ~/.local_extras
