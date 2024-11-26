# .zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Terminal Setup ###
# Powerlevel10k
# TODO: Remove unneeded source command
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# TODO: Remove unneeded source commands
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Aliases
#
# Development
alias sub="git submodule init && git submodule update --remote --recursive"
alias ups="git submodule update --remote --recursive && git add . && git commit -m 'Update submodules' && git push origin"
#
# System
# TODO: Remove or uncomment bat alias
# alias bat="batcat"
alias ff="fastfetch"
alias fp="ps aux | grep"
alias home="cd && clear && echo '' && fastfetch && ls"
alias kanye="curl -s https://api.kanye.rest | jq '.quote'"
alias ls="eza --color=always --icons=always"
alias lls="eza -la"
alias neo="clear && echo '' && fastfetch"
alias scan="sudo freshclam && sudo clamscan -i -r"
alias status="protonvpn-cli status"
alias ts="bash $HOME/Projects/tmux-scripts/tmux-setup.sh"
# TODO: Remove unneeded update commands
# alias update="brew upgrade && brew update && brew autoremove && brew cleanup"
# alias update="sudo apt upgrade -y && sudo apt update -y && sudo flatpak update -y && sudo apt autoremove -y"
# alias update="sudo dnf upgrade -y && sudo apt dnf update -y && sudo flakptak update -y && sudo dnf autoremove -y"
# alias update="sudo pacman -Syu --noconfirm && yay -Sc --noconfirm"
alias vpn="protonvpn-cli connect"
#
# Taskwarrior
alias tw="clear && task calendar && task list"

# Environment Variables
#
# Default Editor
export NVIM=nvim
export EDITOR="$NVIM"
# GitHub Token
export GITHUB_PERSONAL_TOKEN="$(op read op://Personal/<Item ID>/token)"
