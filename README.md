# 🏠 DevOps Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform Support](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20WSL-blue.svg)](#platform-support)
[![Shell Support](https://img.shields.io/badge/Shell-Zsh%20%7C%20Bash-green.svg)](#shell-configurations)

> **A production-ready dotfiles configuration designed for DevOps engineers and infrastructure automation professionals**

Welcome to my dotfiles repository! This setup provides a complete development environment optimized for DevOps workflows, infrastructure automation.

## ✨ Features

- 🚀 **One-command setup** - Get productive in minutes
- 🎨 **Consistent theming** - Catppuccin Mocha across all tools
- 🔧 **DevOps-optimized** - Pre-configured for K8s, Docker, Git workflows
- 📦 **Cross-platform** - Linux, macOS, and WSL support
- 🔄 **Automated updates** - Version-pinned tools with easy upgrade paths
- 💡 **AI-assisted prompts** - Built-in prompt templates for development workflows

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/repos/personal/dotfiles
cd ~/repos/personal/dotfiles

# Run the installer (requires internet connection)
./install

# Restart your shell or run
exec zsh
```

That's it! Your development environment is ready. 🎉

## 🛠️ What's Included

### Core Development Tools

| Tool | Purpose | Configuration Highlights |
|------|---------|-------------------------|
| [**Ghostty**](https://mitchellh.com/ghostty) | Modern terminal emulator | Catppuccin theme, JetBrains Mono font |
| [**Tmux**](https://github.com/tmux/tmux) | Terminal multiplexer | Catppuccin theme, Neovim integration |
| [**Neovim**](https://neovim.io/) | Text editor | LazyVim base, DevOps plugins, Copilot |
| [**Starship**](https://starship.rs/) | Cross-shell prompt | Git info, Docker context, K8s context |
| [**Zsh**](https://zsh.sourceforge.io/) | Advanced shell | Auto-suggestions, syntax highlighting |

### DevOps & Infrastructure Tools

| Tool | Purpose | Version |
|------|---------|---------|
| [**Lazygit**](https://github.com/jesseduffield/lazygit) | Git TUI | v0.51.1 |
| [**Kubectl**](https://kubernetes.io/docs/reference/kubectl/) | Kubernetes CLI | Latest |
| [**K9s**](https://k9scli.io/) | Kubernetes TUI | Latest |
| [**Helm**](https://helm.sh/) | Kubernetes package manager | Latest |
| [**Docker**](https://www.docker.com/) | Container platform | Config ready |

### Productivity Tools

| Tool | Purpose | Version |
|------|---------|---------|
| [**Fzf**](https://github.com/junegunn/fzf) | Fuzzy finder | v0.62.0 |
| [**Ripgrep**](https://github.com/BurntSushi/ripgrep) | Fast grep | v14.1.0 |
| [**Fd**](https://github.com/sharkdp/fd) | Fast file finder | v10.2.0 |
| [**Bat**](https://github.com/sharkdp/bat) | Better cat | v0.25.0 |
| [**Eza**](https://github.com/eza-community/eza) | Modern ls | v0.20.21 |
| [**Yazi**](https://github.com/sxyazi/yazi) | Terminal file manager | v25.5.31 |
| [**Zoxide**](https://github.com/ajeetdsouza/zoxide) | Smart cd | v0.9.8 |
| [**Direnv**](https://direnv.net/) | Environment switcher | v2.35.0 |

## 🏗️ Architecture Overview

```
dotfiles/
├── install                    # Main entry point
├── setup_dotfiles            # Environment initialization
├── scripts/                  # Installation and utility scripts
│   ├── install_packages      # Package installation automation
│   ├── install_nvim          # Neovim from source
│   ├── install_k8s           # Kubernetes tools
│   ├── setup                 # Configuration symlink management
│   ├── utils                 # Core utilities (Clean Architecture)
│   ├── logs                  # Structured logging
│   └── checker               # System validation
├── config/                   # XDG Base Directory configurations
│   ├── starship/             # Cross-shell prompt config
│   ├── yazi/                 # File manager config
│   ├── lazygit/              # Git TUI config
│   └── eza/                  # Modern ls config
├── shell/                    # Shell configurations
│   ├── zsh/                  # Zsh config with plugins
│   └── bash/                 # Bash configuration
├── git/                      # Git configuration and templates
│   ├── config                # Main git config
│   └── template              # Commit message template
├── nvim/                     # Neovim configuration (LazyVim)
├── tmux/                     # Tmux configuration
├── ghostty/                  # Terminal emulator config
├── yazi/                     # File manager config
├── nix/                      # Nix package manager config
├── prompts/                  # AI assistant prompt templates
└── vscode/                   # VS Code profiles
```

## 🎨 Theming

All tools use the **Catppuccin Mocha** theme for a consistent, eye-friendly dark experience:

- 🎨 **Ghostty**: Catppuccin Mocha with JetBrains Mono
- 🖥️ **Tmux**: Catppuccin status bar and panes
- ⌨️ **Neovim**: Catppuccin syntax highlighting
- 🚀 **Starship**: Catppuccin-inspired prompt colors
- 🔍 **Lazygit**: Catppuccin UI theme
- 📁 **Yazi**: Catppuccin file manager theme

## 🔧 Configuration Highlights

### Shell Environment

- **Vi mode** enabled by default
- **Auto-suggestions** and syntax highlighting
- **Environment management** with direnv

### Neovim Setup

Built on **LazyVim** with DevOps-focused enhancements:

- 🤖 **GitHub Copilot** integration
- 🔗 **Tmux navigation** seamless pane switching
- 📁 **Yazi integration** file management
- 🌳 **Lazygit integration** Git workflow
- 🎨 **Catppuccin theme** consistent styling

### Tmux Configuration

- **Catppuccin theme** with custom status bar
- **Vim-style navigation** between panes
- **Plugin manager** (TPM) with continuum for session persistence
- **Seamless Neovim integration** with vim-tmux-navigator

## 🚦 Installation Options

### Full Installation
```bash
./install                    # Complete setup with all tools
```

### Selective Installation
```bash
./setup_dotfiles            # Just configure dotfiles (no package installation)
./scripts/install_packages  # Only install development tools
./scripts/install_k8s       # Only install Kubernetes tools
./scripts/install_nvim      # Build Neovim from source
```

### Package Management
```bash
# Nix support for declarative package management
nix develop                 # Enter development shell
```

## 🤖 AI-Powered Development

Includes prompt templates for common DevOps tasks:

- 📝 **Architecture guidance** - Clean Architecture patterns
- 🐳 **Dockerfile optimization** - Container best practices
- 🔧 **Automation scripts** - Infrastructure automation
- 🔍 **Security reviews** - Code and configuration audits
- 📚 **Documentation** - README and code documentation
- 🧪 **Testing strategies** - Unit and integration tests

Access prompts in the `prompts/` directory.

## 🌍 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| **Ubuntu/Debian** | ✅ Full | Primary development platform |
| **Fedora/RHEL** | ✅ Full | Complete package manager support |
| **Arch Linux** | ✅ Full | Pacman integration |
| **macOS** | ✅ Full | Homebrew and Nix support |
| **WSL2** | ✅ Full | Windows Subsystem for Linux |
| **Alpine** | ⚠️ Limited | Basic tools only |

## 🔄 Updating

The dotfiles include version-pinned tools for stability. To update:

```bash
# Pull latest configurations
git pull origin main

# Update git submodules
git submodule update --init --recursive

# Re-run setup to apply changes
./setup_dotfiles

# Update packages (edit versions in scripts/install_packages)
./scripts/install_packages
```

## 🛠️ Customization

### Adding New Tools

1. **Add to install script**: Edit `scripts/install_packages`
2. **Create configuration**: Add config files in appropriate directory
3. **Update setup**: Add symlinks in `scripts/setup`
4. **Test installation**: Run selective installation

### Custom Scripts

Add custom automation scripts following the Clean Architecture pattern:
- **Domain logic**: Pure functions in `scripts/utils`
- **Use cases**: Main functionality in `scripts/`
- **Infrastructure**: Platform-specific implementations

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Follow the existing code structure and Clean Architecture principles
4. Test on at least one supported platform
5. Submit a pull request with a clear description

### Development Guidelines

- **Logging**: Use structured logging functions from `scripts/logs`
- **Error handling**: Implement proper error handling with cleanup
- **Testing**: Test scripts on clean environments
- **Documentation**: Update README for new features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Catppuccin](https://github.com/catppuccin/catppuccin) - Beautiful pastel theme
- [LazyVim](https://www.lazyvim.org/) - Neovim distribution
- [Starship](https://starship.rs/) - Cross-shell prompt
- [TPM](https://github.com/tmux-plugins/tpm) - Tmux Plugin Manager

---

<div align="center">

**Happy coding! 🚀**

*Built with ❤️ for the DevOps community*

</div>
