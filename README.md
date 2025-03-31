# My dotfiles

This repository provides a submodule to hold my dotfiles; this submodule is consumed as part of automated setup scripts for my development environments.

## Alacritty

- `/alacritty/alacritty.toml`: Alacritty configuration file that sets shell preferences.
    - See [Alacritty configuration](https://alacritty.org/config-alacritty.html) for more details.

## Ghostty

- `/ghostty/config`: Ghostty configuration file that sets shell preferences.
    - See [Ghostty configuration](https://ghostty.org/docs/config) for more details.

## Kitty

- `/kitty/kitty.conf`: Kitty configuration file that sets shell preferences.
    - See [Kitty.conf](https://sw.kovidgoyal.net/kitty/conf/) for more details.

## Neovim

- `~/.config/nvim/`: Neovim directory and scripts that manage configurations, editor preferences, key bindings, and plugins.
    - This neovim setup requires the Packer package manager. See [Install Packer](https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#quickstart) for more details.

## Taskwarrior

- `/taskwarrior/.taskrc`: Taskwarrior runtime configuration that sets ordering, priority, and themes.
- `/taskwarrior/themes/*.theme`: Git submodule with custom themes for Taskwarrior.

## Vim

- `/vim/.vimrc`: Vim runtime configuration that sets editor preferences.

## VS Code

- `/vs-code/settings.json`: VS Code JSON settings file that sets IDE preferences; this file is stored at a path that varies by operating system.

## Z-Shell

- `~/.zshrc`: Z-Shell runtime configuration that configures aliases, environment variables, key bindings, and plugins.
    - The recommended shell configuration at `oh-my-posh/.zshrc` uses `oh-my-posh`. For more details on `oh-my-posh`, see the [oh-my-posh docs](https://ohmyposh.dev/).
    - There additional shell configurations at `oh-my-zsh/.zshrc` and `powerlevel10k/.zshrc`.
        - For more details on the `oh-my-zsh` insallation, see the [oh-my-zsh installation docs](https://ohmyz.sh/#install).
        - Fore more details on the (deprecated) `powerlevel10k` configuration, see the [powerlevel10k GitHub repository](https://github.com/romkatv/powerlevel10k).
