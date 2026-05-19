# shellcheck shell=bash
# macOS — sourced from ~/.zshrc (Homebrew layout)

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases
alias update="brew upgrade && brew update && brew autoremove && brew cleanup -s"

### Theme — Oh My Posh (DOTFILES + DOTFILES_THEME → config/oh-my-posh/themes/*.json)
# Other upstream examples (optional):
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/amro.omp.json)"
# shellcheck source=/dev/null
[[ -n "${DOTFILES:-}" && -f "$DOTFILES/home/zsh/oh-my-posh-theme.zsh" ]] && source "$DOTFILES/home/zsh/oh-my-posh-theme.zsh"
