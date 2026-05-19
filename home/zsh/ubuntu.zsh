# shellcheck shell=bash
# Ubuntu / Debian — sourced from ~/.zshrc

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update="sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt update -y && sudo flatpak update -y && sudo apt autoremove -y && sudo apt autoclean -y"

### Theme — Oh My Posh (dotfiles: DOTFILES_THEME + oh-my-posh-theme.zsh); or pick a stock theme:
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/amro.omp.json)"
# shellcheck source=/dev/null
[[ -n "${DOTFILES:-}" && -f "$DOTFILES/home/zsh/oh-my-posh-theme.zsh" ]] && source "$DOTFILES/home/zsh/oh-my-posh-theme.zsh"
