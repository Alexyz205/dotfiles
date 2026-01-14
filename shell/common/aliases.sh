#!/bin/bash
# ===============================================
# Shared Aliases
# ===============================================
# Common aliases shared across all shells.
# This file should be sourced by shell-specific configurations.
#
# Usage: source "$SHELL_DIR/common/aliases.sh"

# ===============================================
# Navigation
# ===============================================
alias dot='cd $DOTFILES'
alias repos='cd $REPOS'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'

# ===============================================
# File Operations
# ===============================================
# Eza (modern ls replacement) with icons and enhanced display
if command -v eza &> /dev/null; then
  alias ls='eza --color=auto --icons'
  alias la='eza -la --icons'
  alias ll='eza -l --git --icons --hyperlink'
  alias lt='eza --tree --level=2 --icons'
  alias lta='eza --tree --level=2 --icons -a'
  alias ltl='eza --tree --level=2 --icons -l'
  alias ldir='eza --long --icons --only-dirs'
  alias lg='eza --grid --icons'
  alias lm='eza --icons --sort=modified'
  alias ld='eza --icons --sort=date'
  alias lz='eza --icons --sort=size'
else
  echo "eza not found, using default ls"
fi

alias f='fzf'

# ===============================================
# Applications
# ===============================================
alias v='nvim'
alias t='tmux attach -t dev || tmux new-session -s dev'
alias p='python'
alias e='exit'
alias c='clear'

# ===============================================
# Git
# ===============================================
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias gp='git pull'
alias gP='git push'
alias gs='git status'
alias lg='lazygit'

# ===============================================
# Container and Kubernetes
# ===============================================
alias k='kubectl'
alias h='helm'
alias hf='helmfile'
alias d='docker'
alias dc='docker-compose'
alias ld='lazydocker'
alias lss='lazyssh'
alias lssh='lazyssh'
alias dru='docker run -it --rm -v ~/repos/dotfiles:/root/dotfiles ubuntu bash'
alias ik8s='$SCRIPTS/install_k8s'
alias da='direnv allow'

# ===============================================
# DevPod
# ===============================================
alias ds='devpod ssh'
alias du='devpod up .'

# ===============================================
# SSH
# ===============================================
alias sshhs='ssh alexyz@192.168.1.100'
