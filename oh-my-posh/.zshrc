# .zshrc

### Terminal Setup ###
# TODO: Remove unneeded init calls (emodipt-extend is preferred theme)
#
# Arch
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

### Plugins ###
# TODO: Remove unneeded plugin sources
#
# Arch
## source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
## source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# Mac
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# Ubuntu
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

### Aliases ###
#
# Development
alias acp="git add . && git commit -m "chore: make some updates" && git push origin"
alias sub="git submodule update --init --remote --recursive"
alias ups="git submodule update --remote --recursive && git add . && git commit -m 'Update submodules' && git push origin"
#
# System
alias ff="fastfetch"
alias fp="ps aux | grep"
alias jfc="pbpaste | jq . | pbcopy"
alias home="cd && clear && echo '' && fastfetch && ls"
alias kanye="curl -s https://api.kanye.rest | jq '.quote'"
alias ls="eza --color=always --icons=always"
alias lls="eza -la"
alias neo="clear && echo '' && fastfetch"
alias scan="sudo freshclam && sudo clamscan -i -r"
alias status="protonvpn-cli status"
alias ts="bash $HOME/Projects/tmux-scripts/tmux-setup.sh"
# TODO: Remove unneeded update aliases
# alias update="brew upgrade && brew update && brew autoremove && brew cleanup -s"
# alias update="sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt update -y && sudo flatpak update -y && sudo apt autoremove -y && sudo apt autoclean -y"
# alias update="sudo dnf upgrade --refresh -y && sudo flatpak update -y && sudo dnf autoremove -y && sudo dnf clean all"
# alias update="sudo pacman -Syu --noconfirm && yay -Syu --noconfirm && sudo pacman -Rns $(pacman -Qtdq) --noconfirm"
alias vpn="protonvpn-cli connect"

### Environment Variables ###
#
# Default Editor
export NVIM=nvim
export EDITOR="$NVIM"
# GitHub Token
export GITHUB_PERSONAL_TOKEN="$(op read op://Personal/v2qupa4sbtlhaigaljzd2t4xei/token)"
