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
   A terminal multiplexer for managing multiple terminal sessions from a single window. The configuration includes custom key bindings, optimized settings for productivity, and seamless integration with Neovim.

2. [**Alacritty**](https://alacritty.org/)
   A fast, GPU-accelerated terminal emulator. The configuration focuses on a clean and minimal interface, with optimized fonts and color schemes.

3. [**Neovim**](https://neovim.io/)
   My custom Neovim configuration, including [NvChad](https://nvchad.com/) as the base, along with additional plugins such as Tmux Navigator and Lazygit for terminal navigation and Git integration.

4. **Zsh**  
   My Zsh is customized with the [Starship](https://starship.rs/guide/) prompt for a fast, minimal, and highly configurable prompt

5. **Setup Scripts**  
   A collection of scripts to automate the installation and configuration of these tools. These scripts help provision a new PC as quickly as possible by installing essential applications, setting up the environment, and applying dotfiles.

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/repos/
```

### 2. Install and Apply Dotfiles

There are various scripts available to install the required software and apply the configurations:

```bash
cd ~/repos/dotfiles
scripts/install
scripts/setup
```
The `install` script will install softwares depending on your OS.
The `setup` script create symlinks in your `.config` folder.

## Conclusion

This dotfiles setup allows me to quickly configure a new environment with all my favorite tools and settings. It’s designed to be fast, lightweight, and highly customizable. Feel free to fork this repository, modify it to fit your own workflow, or contribute to make it even better!
