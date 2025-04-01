# My dotfiles

This repository holds the dotfiles I use for my personal development environments.

## Primary Programs

### Alacritty

- `/alacritty/alacritty.toml`: Alacritty configuration file that sets shell preferences.
    - See [Alacritty configuration](https://alacritty.org/config-alacritty.html) for more details.

### Ghostty

- `/ghostty/config`: Ghostty configuration file that sets shell preferences.
    - See [Ghostty configuration](https://ghostty.org/docs/config) for more details.

### Neovim

- `/nvim/`: Neovim directory and scripts that manage editor preferences, key bindings, plugins, and other preferences.
    - This neovim setup requires the Packer package manager. See [Install Packer](https://github.com/wbthomason/packer.nvim?tab=readme-ov-file#quickstart) for more details.

### Tmux

- `/tmux/.tmux.conf`: Tmux configuration file that sets key bindings, themes, and other preferences.

### Vim

- `/vim/.vimrc`: Vim runtime configuration that sets editor preferences.

### VS Code

- `/vs-code/settings.json`: VS Code JSON settings file that sets IDE preferences.
    - This file is stored at varying file paths depending on the operating system.

### Z-Shell

- `/oh-my-posh/.zshrc`: Z-Shell runtime configuration that configures aliases, environment variables, key bindings, and plugins.
    - The preferred shell configuration uses `oh-my-posh`. For more details on `oh-my-posh`, see the [oh-my-posh docs](https://ohmyposh.dev/).

## Deprecated and Other Programs

### Kitty

- `/other/kitty/kitty.conf`: Kitty configuration file that sets shell preferences.
    - See [Kitty.conf](https://sw.kovidgoyal.net/kitty/conf/) for more details.

### Taskwarrior

- `/other/taskwarrior/.taskrc`: Taskwarrior runtime configuration that sets ordering, priority, and themes.
- `/other/taskwarrior/themes/*.theme`: Git submodule with custom themes for Taskwarrior.

### Z-Shell

- `/other/oh-my-zsh/.zshrc`: Z-Shell runtime configuration that configures aliases, environment variables, key bindings, and plugins.
    - For more details on the `oh-my-zsh` installation, see the [oh-my-zsh installation docs](https://ohmyz.sh/#install).
- `/deprecated/powerlevel10k/.zshrc`: Z-Shell runtime configuration that configures aliases, environment variables, key bindings, and plugins.
    - For more details on the (deprecated) `powerlevel10k` configuration, see the [powerlevel10k GitHub repository](https://github.com/romkatv/powerlevel10k).

## Maintainers

[@garretpatten](https://github.com/garretpatten/)

## License

This project is licensed under the [MIT License](./LICENSE).
