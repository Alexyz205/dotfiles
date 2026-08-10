# DevOps Dotfiles

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A production-ready dotfiles configuration managed with Nix and home-manager.

## Quick Start

**One-liner** — installs Nix, clones the repo, builds and activates:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Alexyz205/dotfiles/main/install.sh)
```

> Use `bash <(...)` so sudo prompts from the Nix installer work.

**Remote host:**

```bash
ssh -t user@host 'bash <(curl -fsSL https://raw.githubusercontent.com/Alexyz205/dotfiles/main/install.sh)'
```

**Or manually:**

```bash
git clone https://github.com/Alexyz205/dotfiles.git ~/repos/personal/dotfiles
cd ~/repos/personal/dotfiles
./install.sh
exec zsh
```

Re-running is safe — it updates the repo and re-activates home-manager.

## What's Included

### Home-manager modules

| Tool | Module | Notes |
|------|--------|-------|
| [Ghostty](https://mitchellh.com/ghostty) | `programs.ghostty` | Catppuccin theme, JetBrains Mono |
| [Tmux](https://github.com/tmux/tmux) | `programs.tmux` | Catppuccin status bar, resurrect/continuum |
| [Neovim](https://neovim.io/) | `home.file` symlink | LazyVim submodule |
| [Starship](https://starship.rs/) | `programs.starship` | Git, Docker, K8s context |
| [Zsh](https://zsh.sourceforge.io/) | `programs.zsh` | Syntax highlighting, autosuggestions, vi mode |
| [Bash](https://www.gnu.org/software/bash/) | `programs.bash` | Vi mode, history control |
| [Git](https://git-scm.com/) | `programs.git` | Delta diff, credential helpers, project includes |
| [Bat](https://github.com/sharkdp/bat) | `programs.bat` | Catppuccin Mocha theme |
| [Eza](https://eza.rocks/) | `programs.eza` | Icons, git status, Catppuccin theme |
| [Lazygit](https://github.com/jesseduffield/lazygit) | `programs.lazygit` | Catppuccin UI, delta renderer |
| [Yazi](https://yazi-rs.github.io/) | `programs.yazi` | Catppuccin theme, shell wrapper |
| [Zoxide](https://github.com/ajeetdsouza/zoxide) | `programs.zoxide` | Smarter cd |

### Additional packages (via Nix)

ripgrep, fd, bat, eza, television, fastfetch, dust, duf, yq, dasel, jq, tree-sitter, delta, diff-so-fancy, glab, gh, devpod, docker-compose, neovim, opencode, fabric-ai, pass, lazydocker, lazyssh, just

### Shell integrations

- **Television** fuzzy finder (Ctrl+T / Ctrl+R widgets for zsh and bash)
- **Starship** prompt with Catppuccin palette
- **Zoxide** directory jumping
- **Zsh-autosuggestions** + **zsh-syntax-highlighting**
- **Fabric** pattern aliases

## Architecture

```
dotfiles/
├── flake.nix              # Nix flake entry point
├── home/                  # Home-manager modules
│   ├── default.nix        # Entry (username, nix settings, stateVersion)
│   ├── env.nix            # Session variables
│   ├── packages.nix       # Package list
│   ├── files.nix          # Symlinks (nvim, opencode, television, themes)
│   ├── programs/          # HM module configs (one per tool)
│   │   ├── starship.nix
│   │   ├── git.nix
│   │   ├── zsh.nix
│   │   ├── bash.nix
│   │   ├── tmux.nix
│   │   ├── bat.nix
│   │   ├── eza.nix
│   │   ├── lazygit.nix
│   │   ├── yazi.nix
│   │   ├── ghostty.nix
│   │   └── zoxide.nix
│   └── shell/             # Shell scripts (aliases, functions, widget overrides)
├── config/                # Static config files (symlinked)
│   ├── ghostty/themes/
│   ├── bat/themes/
│   ├── eza/theme.yml
│   ├── delta/catppuccin.gitconfig
│   ├── television/        # Cable channels (TV channels)
│   └── opencode/
├── devshells/             # Nix dev shell
├── examples/              # Project templates (devShell + Justfile)
├── install.sh             # One-command installer
├── Justfile               # Task runner (build, deploy, clean, switch)
└── nvim/                  # Neovim config (submodule)
```

## Theming

All tools use **Catppuccin Mocha**:

- Ghostty — Catppuccin Mocha palette + JetBrains Mono font
- Tmux — Catppuccin status bar with custom separators
- Starship — Catppuccin palette across all modules
- Bat — Catppuccin Mocha syntax theme
- Eza — Catppuccin file/directory colors
- Yazi — Catppuccin file manager theme
- Lazygit — Catppuccin UI
- Delta — Catppuccin git diff colors
- K9s — Catppuccin skin (excluded from dotfiles, configured per project)

## Installation Options

### Local

```bash
./install.sh
```

This installs Nix (if missing), clones/updates the repo, enables flakes, builds the home-manager generation, and activates it.

### Remote

```bash
ssh -t user@host 'bash <(curl -fsSL https://raw.githubusercontent.com/Alexyz205/dotfiles/main/install.sh)'
```

### Project-specific tools

Kubernetes, Helm, K9s, and other project-specific tools are not included in the dotfiles. Each project manages its own dependencies via a `flake.nix` devShell. See `examples/` for a template:

```bash
cp examples/project-flake.nix /path/to/project/flake.nix
cp examples/Justfile /path/to/project/Justfile
cd /path/to/project
nix develop
```

## Updating

```bash
git pull origin main
git submodule update --init --recursive
just switch
```

Or to update Nix packages to the latest available versions:

```bash
just update
just switch
```

## Maintenance Commands

```bash
just build     # Build activation package
just switch    # Build + activate
just update    # Update flake inputs
just clean     # Garbage collect
just dev       # Enter dev shell
```

## Customization

Adding a new tool:

1. Add to `home/packages.nix` if it's a standalone package
2. Add a HM module in `home/programs/` if the tool has a home-manager module
3. Add aliases in `home/shell/aliases.nix`
4. Run `just switch`

## Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| **Ubuntu/Debian** | ✅ Full | Primary target |
| **Fedora/RHEL** | ✅ Full | Nix-based |
| **macOS** | ✅ Full | Nix-based |
| **WSL2** | ✅ Full | Windows Subsystem for Linux |
| **Alpine** | ⚠️ Limited | Basic Nix support |

## License

MIT — see [LICENSE](LICENSE).
