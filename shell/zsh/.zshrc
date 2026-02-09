#!/bin/zsh
# ===============================================
# Zsh Configuration (Modular)
# ===============================================
# Main Zsh configuration file with modular architecture.
# Sources shared configurations and Zsh-specific settings.
#
# Author: Alexis
# Version: 3.0
# Last Updated: 2025-01-14

# ===============================================
# Vi Mode
# ===============================================
set -o vi

# ===============================================
# Detect Shell Directory
# ===============================================
# Determine the location of shell configuration files
# Use the actual file location, not the symlink
ZSHRC_PATH="${${(%):-%x}:A}"
SHELL_DIR="${ZSHRC_PATH:h:h}"
export SHELL_DIR

# ===============================================
# Source Common Configurations
# ===============================================
# Load shared configurations used across all shells

# Environment variables
if [ -f "$SHELL_DIR/common/env.sh" ]; then
  source "$SHELL_DIR/common/env.sh"
fi

# FZF configuration
if [ -f "$SHELL_DIR/common/fzf.sh" ]; then
  source "$SHELL_DIR/common/fzf.sh"
fi

# ===============================================
# Source Zsh-Specific Configuration
# ===============================================
# Load Zsh-only features and optimizations
# This must come before tools.sh so mise is activated first

if [ -f "$SHELL_DIR/zsh/zsh_specific.sh" ]; then
  source "$SHELL_DIR/zsh/zsh_specific.sh"
fi

# Tool availability checks (after mise activation)
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
# Tmux Auto-Start
# ===============================================
# Automatically start or attach to tmux session
# Set TMUX_AUTO_START=0 to disable this behavior
tmux_auto_start
