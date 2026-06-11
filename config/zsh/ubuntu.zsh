# shellcheck shell=bash
# Ubuntu / Debian — sourced from ~/.zshrc

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update="sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo flatpak update -y && sudo apt autoremove -y && sudo apt autoclean -y"
