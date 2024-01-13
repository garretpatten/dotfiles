export PATH=$HOME/bin:$HOME/.local/bin:/usr/bin:/usr/local/bin:/usr/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="avit"
# ZSH_THEME="bureau"
# ZSH_THEME="cloud"
# ZSH_THEME="fino"
# ZSH_THEME="gozilla"
# ZSH_THEME="rixius"
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Aliases
#
# System
# alias bat="batcat"
alias fp="ps aux | grep"
alias home="clear && echo '' && neofetch && task list"
alias ls="exa"
alias neo="neofetch"
alias scan="sudo freshclam && sudo clamscan -i -r"
# TODO: Remove unneeded update commands
# alias update="brew upgrade && brew update && brew autoremove && brew cleanup"
# alias update="sudo apt upgrade -y && sudo apt update -y && sudo flatpak update -y && sudo apt autoremove -y"
# alias update="sudo dnf upgrade -y && sudo apt dnf update -y && sudo flakptak update -y && sudo dnf autoremove -y"
# alias update="sudo pacman -Syu && yay -Sc"
alias status="clear && neofetch && task calendar && task list && protonvpn-cli status"
#
# Taskwarrior
alias tw="clear && task calendar && task list"
#
# Zsh
alias ohmyzsh="nano ~/.oh-my-zsh"
alias zshconfig="nano ~/.zshrc"

# Environment Variables
#
# TODO: Update Item ID and uncomment token export
# export GITHUB_PERSONAL_TOKEN="$(op read op://Personal/<Item ID>/token)"
