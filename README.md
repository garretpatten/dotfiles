# My dotfiles
This repository provides a submodule to hold my dotfiles; this submodule is consumed as part of automated setup scripts for my development environments.

## Alacritty
- `~/.config/alacritty/alacritty.toml`: Alacritty configuration file that sets shell preferences
    - See [Alacritty configuration](https://alacritty.org/config-alacritty.html) for more details.

## Neovim
- `~/.config/nvim/init.vim`: Neovim configuration file that sets editor preferences
    - This neovim setup requires the Packer package manager. See [Install Packer](https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#quickstart) for more details.

## Taskwarrior
- `~/.taskrc`: Taskwarrior configuration file that sets ordering, priority, and theme.
- `/.task/themes/*.theme`: Custom themes for Taskwarrior.

## Vim
- `~/.vimrc`: Vim configuration file that sets editor preferences.

## VS Code
- `settings.json`: VS Code JSON settings file that sets IDE preferenecs; this file is stored at a path that varies by operating system.

## Z-Shell
- `~/.zshrc`: Z-Shell configuration file that mostly provides needed aliases.
    - Default shell configuration at `zsh/.zshrc` uses `powerlevel10k` and installed plugins.
    - There is another shell configuration that relies on `oh-my-zsh` at `oh-my-zsh/.zshrc`. See [oh-my-zsh Basic Installation] for more details. 
