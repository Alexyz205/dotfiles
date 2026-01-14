#!/bin/bash
# ===============================================
# Tool Initializations
# ===============================================
# Common tool initialization commands shared across all shells.
# This file should be sourced by shell-specific configurations.
#
# Usage: source "$SHELL_DIR/common/tools.sh"

# ===============================================
# Starship Prompt
# ===============================================
# Initialize starship cross-shell prompt if available
if command -v starship &> /dev/null; then
  # Shell-specific initialization will be handled by the sourcing shell
  # This is just a marker that starship is available
  export STARSHIP_AVAILABLE=1
else
  echo "Starship not found, skipping initialization."
  export STARSHIP_AVAILABLE=0
fi

# ===============================================
# Zoxide (Smart cd)
# ===============================================
# Initialize zoxide if available
if command -v zoxide &> /dev/null; then
  export ZOXIDE_AVAILABLE=1
else
  echo "zoxide not found, skipping initialization."
  export ZOXIDE_AVAILABLE=0
fi

# ===============================================
# Direnv (Environment Switcher)
# ===============================================
# Initialize direnv if available
if command -v direnv &> /dev/null; then
  export DIRENV_AVAILABLE=1
else
  echo "direnv not found, skipping initialization."
  export DIRENV_AVAILABLE=0
fi

# ===============================================
# FZF (Fuzzy Finder)
# ===============================================
# Initialize fzf if available
if command -v fzf &> /dev/null; then
  export FZF_AVAILABLE=1
  # Load fzf from legacy location if it exists
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash 2>/dev/null
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 2>/dev/null
else
  echo "fzf not found, skipping fzf initialization."
  export FZF_AVAILABLE=0
fi
