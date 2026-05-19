# shellcheck shell=bash
# macOS — sourced from ~/.zshrc (Homebrew layout)

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update="brew upgrade && brew update && brew autoremove && brew cleanup -s"

### Oh My Posh (Gruvbox dark hard default; switch with DOTFILES_THEME — see home/zsh/theme-env.sh)
if command -v oh-my-posh >/dev/null 2>&1 && [[ -n "${DOTFILES:-}" ]]; then
  _omp_cfg="${DOTFILES}/home/zsh/oh-my-posh-theme.zsh"
  if [[ -f "$_omp_cfg" ]]; then
    # shellcheck disable=SC1091
    . "$_omp_cfg"
  fi
fi
