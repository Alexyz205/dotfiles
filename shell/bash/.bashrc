#!/bin/bash
# ===============================================
# Bash Configuration (Modular)
# ===============================================
# Main Bash configuration file with modular architecture.
# Sources shared configurations and Bash-specific settings.
#
# Author: Alexis
# Version: 3.0
# Last Updated: 2026-02-10

# ===============================================
# Vi Mode
# ===============================================
set -o vi

# ===============================================
# Detect Shell Directory
# ===============================================
# Determine the location of shell configuration files
# Resolve symlinks to get the actual file location
if [ -n "${BASH_SOURCE[0]}" ]; then
  BASHRC_PATH="$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || realpath "${BASH_SOURCE[0]}" 2>/dev/null || echo "${BASH_SOURCE[0]}")"
  SHELL_DIR="$(cd "$(dirname "$BASHRC_PATH")/.." && pwd)"
elif [ -d "$HOME/repos/dotfiles/shell" ]; then
  SHELL_DIR="$HOME/repos/dotfiles/shell"
else
  SHELL_DIR="$HOME/.config/shell"
fi

export SHELL_DIR

# ===============================================
# Source Common Configurations
# ===============================================
# Load shared configurations used across all shells

# FZF configuration
if [ -f "$SHELL_DIR/common/fzf.sh" ]; then
  source "$SHELL_DIR/common/fzf.sh"
fi

# ===============================================
# Source Bash-Specific Configuration
# ===============================================
# Load Bash-only features and optimizations

if [ -f "$SHELL_DIR/bash/bash_specific.sh" ]; then
  source "$SHELL_DIR/bash/bash_specific.sh"
fi

# Tool initializations (includes mise activation)
if [ -f "$SHELL_DIR/common/tools.sh" ]; then
  source "$SHELL_DIR/common/tools.sh"
fi

# Shared functions
if [ -f "$SHELL_DIR/common/functions.sh" ]; then
  source "$SHELL_DIR/common/functions.sh"
fi

# Shared aliases
if [ -f "$SHELL_DIR/common/aliases.sh" ]; then
  source "$SHELL_DIR/common/aliases.sh"
fi

# ===============================================
# Locale Configuration
# ===============================================
export LANG=en_US.UTF-8

# ===============================================
# Tmux Auto-Start
# ===============================================
# Automatically start or attach to tmux session
# Set TMUX_AUTO_START=0 to disable this behavior
tmux_auto_start
