# shellcheck shell=bash
### XDG base dirs (defaults per spec; tools honor these in config files)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

### Default UI theme (gruvbox; override with DOTFILES_THEME or persist in ~/.local_extras)
export DOTFILES_THEME="${DOTFILES_THEME:-gruvbox}"

### Cursor / VS Code integrated terminal (alternate-screen leak → wheel mimics arrows)
# When the tty is stuck in alternate-screen semantics, the wheel sends ^[[A/B;
# home/.zshrc maps those to history search. Leave alt screen before each prompt.
# Opt out: DISABLE_DOTFILES_VSCODE_ALTSCR_FIX=1
if [[ "${TERM_PROGRAM:-}" == vscode && -z "${DISABLE_DOTFILES_VSCODE_ALTSCR_FIX:-}" ]]; then
  _dotfiles_precmd_vscode_leave_alt_scr() {
    [[ -t 1 ]] || return 0
    printf '\033[?1049l'
  }
  precmd_functions+=(_dotfiles_precmd_vscode_leave_alt_scr)
fi

### OS-specific plugins and update aliases — see ~/.config/zsh/*.zsh
_zsh_cfg="${XDG_CONFIG_HOME}/zsh"
case "$(uname -s)" in
  Darwin)
    # shellcheck source=/dev/null
    [[ -f "$_zsh_cfg/darwin.zsh" ]] && source "$_zsh_cfg/darwin.zsh"
    ;;
  Linux)
    if [[ -r /etc/os-release ]]; then
      # shellcheck source=/dev/null
      . /etc/os-release
      case "${ID:-}" in
        debian | ubuntu | linuxmint)
          # shellcheck source=/dev/null
          [[ -f "$_zsh_cfg/ubuntu.zsh" ]] && source "$_zsh_cfg/ubuntu.zsh"
          ;;
        arch | archlinux)
          # shellcheck source=/dev/null
          [[ -f "$_zsh_cfg/arch.zsh" ]] && source "$_zsh_cfg/arch.zsh"
          ;;
        fedora)
          # shellcheck source=/dev/null
          [[ -f "$_zsh_cfg/fedora.zsh" ]] && source "$_zsh_cfg/fedora.zsh"
          ;;
      esac
    fi
    ;;
esac
unset _zsh_cfg

### Oh My Posh
if command -v oh-my-posh >/dev/null 2>&1; then
  _omp_cfg="${XDG_CONFIG_HOME}/zsh/oh-my-posh-theme.zsh"
  # shellcheck source=/dev/null
  [[ -f "$_omp_cfg" ]] && source "$_omp_cfg"
  unset _omp_cfg
fi

### Syntax highlighting colors (theme-aware)
# Theme files live in ~/.config/zsh/themes and are loaded after the
# OS-specific plugin files source zsh-syntax-highlighting.
# shellcheck source=/dev/null
case "${DOTFILES_THEME:-gruvbox}" in
  everforest)
    [[ -f "${XDG_CONFIG_HOME}/zsh/themes/everforest-syntax.zsh" ]] &&
      source "${XDG_CONFIG_HOME}/zsh/themes/everforest-syntax.zsh"
    ;;
  *)
    [[ -f "${XDG_CONFIG_HOME}/zsh/themes/gruvbox-syntax.zsh" ]] &&
      source "${XDG_CONFIG_HOME}/zsh/themes/gruvbox-syntax.zsh"
    ;;
esac

### Paths
#
# LM Studio CLI
export PATH="$PATH:$HOME/.lmstudio/bin"
#
# Proton Pass CLI
export PATH="$HOME/.local/bin:$PATH"

### Aliases
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

### Environment Variables
#
export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"

### NVM (lazy-loaded — first call to nvm/node/npm/npx triggers real load)
_nvm_lazy_load() {
  unset -f nvm node npm npx
  # shellcheck disable=SC1091
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  # shellcheck disable=SC1091
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm()  { _nvm_lazy_load; nvm  "$@"; }
node() { _nvm_lazy_load; node "$@"; }
npm()  { _nvm_lazy_load; npm  "$@"; }
npx()  { _nvm_lazy_load; npx  "$@"; }

### History
#
HISTFILE=$HOME/.zhistory
# shellcheck disable=SC2034
SAVEHIST=50000
HISTSIZE=50000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# shellcheck source=/dev/null
[[ -f ~/.local_extras ]] && source ~/.local_extras
