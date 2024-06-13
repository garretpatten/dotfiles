# .zshrc

### Terminal Setup ###
#
# Arch
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/amro.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/atomic.omp.json)"
# eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/blueish.omp.json)"
eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/emodipt-extend.omp.json)"
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

### Plugins ###
#
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
alias ups="git submodule update --remote --recursive && git add . && git commit -m 'Update submodules' && git push origin"
#
# System
alias ff="fastfetch"
alias fp="ps aux | grep"
alias home="clear && echo '' && fastfetch && task list"
alias ls="eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lls="exa -la"
alias neo="clear && echo '' && fastfetch"
alias scan="sudo freshclam && sudo clamscan -i -r"
alias status="clear && neofetch && task calendar && task list && protonvpn-cli status"
alias update="sudo pacman -Syu --noconfirm && yay -Sc --noconfirm"
#
# Taskwarrior
alias tw="clear && task calendar && task list"

### Environment Variables ###
#
# Default Editor
export NVIM=nvim
export EDITOR="$NVIM"
# GitHub Token
export GITHUB_PERSONAL_TOKEN="$(op read op://Personal/<Item ID>/token)"
