### Paths ###
#
# LM Studio CLI
export PATH="$PATH:/Users/garret/.lmstudio/bin"
#
# Proton Pass CLI
export PATH="/Users/garret/.local/bin:$PATH"

### Plugins ###
#
# Arch
#
## source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
## source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# Mac
#
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# Ubuntu
#
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Aliases ###
#
# Development
alias acp="git add . && git commit -m "chore: make some updates" && git push origin"
alias sub="git submodule update --init --remote --recursive"
alias ups="git submodule update --remote --recursive && git add . && git commit -m 'Update submodules' && git push origin"
#
# System
alias cbg="bash $HOME/Projects/system-scripts/code-backup/code-backup-gitlab.sh"
alias cbl="bash $HOME/Projects/system-scripts/code-backup/code-backup-local.sh"
alias ff="fastfetch"
alias fp="ps aux | grep"
alias jfc="pbpaste | jq . | pbcopy"
alias home="cd && clear && echo '' && fastfetch && ls"
alias kanye="curl -s https://api.kanye.rest | jq '.quote'"
alias ls="eza --color=always --icons=always"
alias lls="eza -la"
alias mdlint='npx markdownlint-cli2 "**/*.md" "#node_modules"'
alias neo="clear && echo '' && fastfetch"
alias prettier="npx prettier --write ."
alias scan="sudo freshclam && sudo clamscan -i -r"
alias status="protonvpn-cli status"
alias sub="git submodule init && git submodule update --remote --recursive"
alias ts="bash $HOME/Projects/tmux-scripts/tmux-setup.sh"
# alias update="brew upgrade && brew update && brew autoremove && brew cleanup -s"
# alias update="sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt update -y && sudo flatpak update -y && sudo apt autoremove -y && sudo apt autoclean -y"
# alias update="sudo dnf upgrade --refresh -y && sudo flatpak update -y && sudo dnf autoremove -y && sudo dnf clean all"
# alias update="sudo pacman -Syu --noconfirm && yay -Syu --noconfirm && sudo pacman -Rns $(pacman -Qtdq) --noconfirm"
alias ups="git submodule update --remote --recursive && git add . && git commit -m 'Update submodules' && git push origin"
alias vpn="protonvpn-cli connect"

### Environment Variables ###
#
# GitHub
export GITHUB_TOKEN=$(pass-cli item view pass://Personal/'GitHub Token (Personal)'/token)
#
# Nvim
export NVIM=nvim
export EDITOR="$NVIM"
export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### History Setup ###
#
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

### Theme ###
#
# Arch
#
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/amro.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/atomic.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/blueish.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/emodipt-extend.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/iterm2.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/negligible.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/powerlevel10k_rainbow.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/sonicboom_dark.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/spaceship.omp.json)"
#
# Mac
#
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/amro.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/atomic.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/blueish.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/emodipt-extend.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/iterm2.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/negligible.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/powerlevel10k_rainbow.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/sonicboom_dark.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/spaceship.omp.json)"
#
# Ubuntu
#
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/amro.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/atomic.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/blueish.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/emodipt-extend.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/iterm2.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/negligible.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/powerlevel10k_rainbow.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/sonicboom_dark.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/spaceship.omp.json)"
