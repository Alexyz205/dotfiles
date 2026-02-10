#!/bin/bash
# ===============================================
# Tool Initializations
# ===============================================
# Common tool initialization commands shared across all shells.
# This file handles tool initialization for mise, starship, zoxide, and fzf
# with automatic shell detection.
#
# Usage: source "$SHELL_DIR/common/tools.sh"

# ===============================================
# Mise (Tool Version Manager)
# ===============================================
# Activate mise early to make tools and environment variables available
if command -v mise &>/dev/null; then
  # Determine the current shell
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(mise activate zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(mise activate bash)"
  fi
  export MISE_AVAILABLE=1
else
  echo "mise not found, some tools may not be available."
  export MISE_AVAILABLE=0
fi

# ===============================================
# Starship Prompt
# ===============================================
# Initialize starship cross-shell prompt if available
if command -v starship &>/dev/null; then
  # Determine the current shell
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(starship init zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(starship init bash)"
  fi
  export STARSHIP_AVAILABLE=1
else
  echo "Starship not found, skipping initialization."
  export STARSHIP_AVAILABLE=0
fi

# ===============================================
# Zoxide (Smart cd)
# ===============================================
# Initialize zoxide if available
if command -v zoxide &>/dev/null; then
  # Determine the current shell
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(zoxide init zsh)"
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(zoxide init bash)"
  fi
  export ZOXIDE_AVAILABLE=1
else
  echo "zoxide not found, skipping initialization."
  export ZOXIDE_AVAILABLE=0
fi

# ===============================================
# FZF (Fuzzy Finder)
# ===============================================
# Initialize fzf if available
if command -v fzf &>/dev/null; then
  export FZF_AVAILABLE=1
  # Shell-specific initialization
  if [ -n "$ZSH_VERSION" ]; then
    source <(fzf --zsh) 2>/dev/null || true
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(fzf --bash)" 2>/dev/null || true
  fi
else
  echo "fzf not found, skipping fzf initialization."
  export FZF_AVAILABLE=0
fi
