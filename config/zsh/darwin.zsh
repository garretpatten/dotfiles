# shellcheck shell=bash
# macOS — sourced from ~/.zshrc (Homebrew layout)

### Zsh plugins (uncomment if installed)
# shellcheck source=/dev/null
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# shellcheck source=/dev/null
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Homebrew Ruby (keg-only; must precede /usr/bin in PATH for gem installs to work)
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"

### Aliases
alias update="brew upgrade && brew update && brew autoremove && brew cleanup -s"
