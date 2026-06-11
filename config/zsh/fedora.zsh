# shellcheck shell=bash
# Fedora — sourced from ~/.zshrc

### Zsh plugins (uncomment if installed; adjust paths if your packages differ)
# shellcheck source=/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update="sudo dnf upgrade --refresh -y && sudo flatpak update -y && sudo dnf autoremove -y && sudo dnf clean all"
