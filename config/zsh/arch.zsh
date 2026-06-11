# shellcheck shell=bash
# Arch Linux — sourced from ~/.zshrc

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update='sudo pacman -Syu --noconfirm && yay -Syu --noconfirm && sudo pacman -Rns $(pacman -Qtdq) --noconfirm'
