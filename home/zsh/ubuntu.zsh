# shellcheck shell=bash
# Ubuntu / Debian — sourced from ~/.zshrc

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update="sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo flatpak update -y && sudo apt autoremove -y && sudo apt autoclean -y"

### Oh My Posh (Gruvbox dark hard default; switch with DOTFILES_THEME — see theme-env.sh)
if command -v oh-my-posh >/dev/null 2>&1 && [[ -n "${DOTFILES:-}" ]]; then
  _omp_cfg="${DOTFILES}/home/zsh/oh-my-posh-theme.zsh"
  if [[ -f "$_omp_cfg" ]]; then
    # shellcheck disable=SC1091
    . "$_omp_cfg"
  fi
fi
