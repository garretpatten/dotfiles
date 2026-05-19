# shellcheck shell=bash
# Fedora — sourced from ~/.zshrc

### Zsh plugins (uncomment if installed; adjust paths if your packages differ)
# shellcheck source=/dev/null
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update="sudo dnf upgrade --refresh -y && sudo flatpak update -y && sudo dnf autoremove -y && sudo dnf clean all"

### Theme — Oh My Posh (dotfiles: DOTFILES_THEME + oh-my-posh-theme.zsh); or pick a stock theme:
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/amro.omp.json)"
# shellcheck source=/dev/null
[[ -n "${DOTFILES:-}" && -f "$DOTFILES/home/zsh/oh-my-posh-theme.zsh" ]] && source "$DOTFILES/home/zsh/oh-my-posh-theme.zsh"
