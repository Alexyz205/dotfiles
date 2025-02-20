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
- 🔄 **Version management** - Mise for declarative tool version control
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
| [**Mise**](https://mise.jdx.dev/) | Tool version manager | Declarative version control for all CLI tools |
| [**Ghostty**](https://mitchellh.com/ghostty) | Modern terminal emulator | Catppuccin theme, JetBrains Mono font |
| [**Tmux**](https://github.com/tmux/tmux) | Terminal multiplexer | Catppuccin theme, Neovim integration |
| [**Neovim**](https://neovim.io/) | Text editor | LazyVim base, DevOps plugins, Copilot (v0.11.5) |
| [**Starship**](https://starship.rs/) | Cross-shell prompt | Git info, Docker context, K8s context |
| [**Zsh**](https://zsh.sourceforge.io/) | Advanced shell | Auto-suggestions, syntax highlighting |

## 🏗️ Architecture Overview

```
dotfiles/
├── install                    # Main entry point
├── setup_dotfiles            # Environment initialization
├── scripts/                  # Installation and utility scripts
│   ├── install_packages       # Mise-based package installation
│   ├── configure_k9s         # K9s theme setup
│   ├── configure_helm        # Helm plugins setup
│   ├── setup                 # Configuration symlink management
│   ├── utils                 # Core utilities (Clean Architecture)
│   ├── logs                  # Structured logging
│   └── checker               # System validation
├── config/                   # XDG Base Directory configurations
│   ├── ghostty/              # Terminal emulator config
│   ├── git/                  # Git configuration
│   ├── lazygit/              # Git TUI config
│   ├── mise/                 # Mise tool version manager config
│   ├── opencode/             # AI assistant config
│   ├── starship/             # Cross-shell prompt config
│   └── tmux/                 # Tmux configuration (submodule)
├── shell/                    # Shell configurations
│   ├── zsh/                  # Zsh config with plugins
│   ├── bash/                 # Bash configuration
│   └── powershell/           # PowerShell configuration
├── nvim/                     # Neovim configuration (LazyVim submodule)
└── scripts/                  # Installation and utility scripts (submodule)
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
- **Environment management** with mise

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

### Full Installation (Recommended)

```bash
./install                    # Complete setup with all tools
```

This will:

1. Initialize git submodules
2. Create symlinks for all configurations  
3. Install mise (tool version manager)
4. Install all tools defined in `config/mise/config.toml`
5. Configure k9s theme and Helm plugins

### Selective Installation

```bash
./setup_dotfiles             # Just configure dotfiles (no package installation)
./scripts/install_packages   # Install mise + all tools + post-install configs
```

### Manual Configuration (Optional)

```bash
./scripts/configure_k9s.sh   # Configure k9s Catppuccin theme
./scripts/configure_helm.sh  # Install Helm plugins (diff, secrets)
```

### Managing Tools with Mise

All development tools are managed by mise and defined in `config/mise/config.toml`:

```bash
# Install all tools from config
mise install

# List installed tools and versions
mise list

# Update a specific tool
mise upgrade node

# Update all tools to latest versions
mise upgrade

# Use different version in a project
cd ~/my-project
echo "node = '20.0.0'" > .mise.toml
mise install

# Add new tools
# Edit config/mise/config.toml, then run:
mise install
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
| **macOS** | ✅ Full | Mise-based tool management |
| **WSL2** | ✅ Full | Windows Subsystem for Linux |
| **Alpine** | ⚠️ Limited | Basic tools only |

## 🔄 Updating

The dotfiles include version-pinned tools managed by mise. To update:

```bash
# Pull latest configurations
git pull origin main

# Update git submodules
git submodule update --init --recursive

# Re-run setup to apply changes
./setup_dotfiles

# Update all tools to versions in config
mise install

# Or upgrade all tools to latest versions
mise upgrade
```

## 🛠️ Customization

### Adding New Tools

1. **Add to mise config**: Edit `config/mise/config.toml`
2. **Install the tool**: Run `mise install`
3. **Create configuration**: Add config files in appropriate directory
4. **Update setup**: Add symlinks in `scripts/setup` if needed
5. **Test**: Verify the tool works

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
