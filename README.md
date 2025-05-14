# My Dotfiles

Welcome to my dotfiles repository! This repository contains the configuration files for the tools I use on a daily basis, along with scripts to set up a development environment quickly and efficiently. The goal of this setup is to make a new PC or environment ready for use with minimal effort, while keeping everything lightweight, optimized, and customizable.

## Why Use Dotfiles?

Dotfiles are the hidden configuration files that define the behavior of various command-line tools and applications. By keeping these in version control, I can:

- **Ensure Consistency**: Quickly apply the same configurations across multiple machines.
- **Improve Productivity**: Optimize my workflow with custom keybindings, aliases, and settings.
- **Easy Setup**: With just a few commands, I can configure a new environment or restore an existing one.

## Philosophy

- **Simple and Efficient**: The setup is designed to be straightforward, focusing on functionality without excessive complexity.
- **Minimal but Powerful**: Each tool and setting is chosen for its utility. I only use what's necessary to keep the system light yet effective.
- **Customizable**: Every aspect of the configuration is modular, making it easy to extend or modify based on individual preferences.

## What's Included

This repository contains configuration files for the following tools:

1. [**Tmux**](https://github.com/tmux/tmux/wiki)
   A terminal multiplexer for managing multiple terminal sessions from a single window. The configuration includes custom key bindings, Catppuccin theme, and seamless integration with Neovim through vim-tmux-navigator.

2. [**Ghostty**](https://mitchellh.com/ghostty)
   A fast, modern terminal emulator. The configuration includes the Catppuccin Mocha theme and JetBrains Mono font for a clean and consistent experience.

3. [**Neovim**](https://neovim.io/)
   My custom Neovim configuration, built on [LazyVim](https://www.lazyvim.org/) for a powerful foundation, along with plugins like vim-tmux-navigator and snacks.nvim for Lazygit integration.

4. **Zsh and Bash**
   Shell configurations with [Starship](https://starship.rs/guide/) prompt for a fast, minimal, and highly configurable prompt, plus useful aliases, environment variables, and plugin integrations including zsh-autosuggestions and zsh-syntax-highlighting.

5. **Lazygit**
   A customized [Lazygit](https://github.com/jesseduffield/lazygit) configuration with Catppuccin theme integration for a streamlined Git workflow.

6. **Setup Scripts**
   A collection of scripts to automate the installation and configuration of these tools. These scripts help provision a new PC as quickly as possible by installing essential applications, setting up the environment, and applying dotfiles.

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/repos/personal/dotfiles
```

### 2. Install and Apply Dotfiles

There are various scripts available to install the required software and apply the configurations:

```bash
cd ~/repos/personal/dotfiles
./install
```

The `install` script will install software dependencies based on your OS, and the `setup_dotfiles` script initializes git submodules and runs the main setup script to create symlinks in your `.config` folder.

## Tools and Integration

The configurations are designed to work together seamlessly:

- **Shell + Starship**: Custom Zsh and Bash configurations with Starship prompt for a beautiful, informative command line
- **Tmux + Neovim**: Seamless navigation between Tmux panes and Neovim splits with vim-tmux-navigator
- **Lazygit + Neovim**: Integration through snacks.nvim for an enhanced Git workflow
- **Cross-platform compatibility**: Works on Linux, macOS, and Windows (WSL)

## Conclusion

This dotfiles setup allows me to quickly configure a new environment with all my favorite tools and settings. It's designed to be fast, lightweight, and highly customizable. Feel free to fork this repository, modify it to fit your own workflow, or contribute to make it even better!
