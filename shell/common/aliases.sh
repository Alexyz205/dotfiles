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
if command -v eza &>/dev/null; then
  alias ls='eza --color=auto --icons=auto'
  alias la='eza -la --icons=auto'
  alias ll='eza -l --git --hyperlink --icons=auto'
  alias lt='eza --tree --level=2 --icons=auto'
  alias lta='eza --tree --level=2 --icons=auto -a'
  alias ltl='eza --tree --level=2 --icons=auto -l'
  alias ldir='eza --long --icons=auto --only-dirs'
  alias lg='eza --grid --icons=auto'
  alias lm='eza --icons=auto --sort=modified'
  alias ld='eza --icons=auto --sort=date'
  alias lz='eza --icons=auto --sort=size'
else
  echo "eza not found, using default ls"
fi

alias f='tv'

# ===============================================
# Applications
# ===============================================
alias v='nvim'
alias t='tmux new-session -A -s dev'
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

# ===============================================
# GitLab (glab CLI)
# ===============================================
alias gm='glab mr'
alias gml='glab mr list'
alias gmv='glab mr view'
alias gmc='glab mr create'
alias gma='glab mr approve'
alias gmm='glab mr merge'
alias gci='glab ci'
alias gcil='glab ci list'
alias gciv='glab ci view'

# ===============================================
# DevPod
# ===============================================
alias ds='devpod ssh'
alias du='devpod up .'

# ===============================================
# Password Manager (pass)
# ===============================================
if command -v pass &>/dev/null; then
  alias pw='pass'
  alias pwls='pass ls'
  alias pwgen='pass generate'
  alias pwcp='pass show -c'
fi

# ===============================================
# AI (fabric)
# ===============================================
# Create aliases for all fabric patterns so they can be run directly,
# e.g. `summarize` instead of `fabric --pattern summarize`
if command -v fabric &>/dev/null && [ -d "$HOME/.config/fabric/patterns" ]; then
  for pattern_file in "$HOME"/.config/fabric/patterns/*; do
    [ -e "$pattern_file" ] || continue
    pattern_name="$(basename "$pattern_file")"
    alias_name="${FABRIC_ALIAS_PREFIX:-}${pattern_name}"
    eval "alias $alias_name='fabric --pattern $pattern_name'"
  done

  # YouTube transcript helper
  yt() {
    if [ "$#" -eq 0 ] || [ "$#" -gt 2 ]; then
      echo "Usage: yt [-t | --timestamps] youtube-link"
      echo "Use the '-t' flag to get the transcript with timestamps."
      return 1
    fi

    transcript_flag="--transcript"
    if [ "$1" = "-t" ] || [ "$1" = "--timestamps" ]; then
      transcript_flag="--transcript-with-timestamps"
      shift
    fi
    local video_link="$1"
    fabric -y "$video_link" $transcript_flag
  }
fi
