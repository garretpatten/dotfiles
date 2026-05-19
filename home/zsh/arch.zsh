# shellcheck shell=bash
# Arch Linux — sourced from ~/.zshrc

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update='sudo pacman -Syu --noconfirm && yay -Syu --noconfirm && sudo pacman -Rns $(pacman -Qtdq) --noconfirm'

### Oh My Posh (Gruvbox dark hard default; switch with DOTFILES_THEME — see theme-env.sh)
if command -v oh-my-posh >/dev/null 2>&1 && [[ -n "${DOTFILES:-}" ]]; then
  _omp_cfg="${DOTFILES}/home/zsh/oh-my-posh-theme.zsh"
  if [[ -f "$_omp_cfg" ]]; then
    # shellcheck disable=SC1091
    . "$_omp_cfg"
  fi
fi
