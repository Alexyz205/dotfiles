#!/bin/zsh
# ===============================================
# Zsh-Specific Configuration
# ===============================================
# Configuration specific to Zsh shell.
# This file contains Zsh-only features and optimizations.
#
# This file is sourced by .zshrc

# ===============================================
# Zsh Options
# ===============================================

# Enable extended globbing
setopt extended_glob

# Correct command spelling
setopt correct

# Don't beep on errors
setopt no_beep

# Allow comments in interactive shell
setopt interactive_comments

# ===============================================
# Path Configuration (Zsh-specific)
# ===============================================

# Add directories to PATH using Zsh array syntax
path=(
    $path                           # Keep existing PATH entries
    $HOME/bin
    $HOME/.local/bin
    $SCRIPTS                        # Add scripts directory to PATH
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# ===============================================
# Zsh Completion System
# ===============================================

# Initialize completion system
autoload -Uz compinit && compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Menu-driven completion
zstyle ':completion:*' menu select

# Completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

# Better completion for kill command
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Colorful completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ===============================================
# History Configuration
# ===============================================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Share history between sessions
setopt share_history

# Ignore duplicate entries
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Ignore commands starting with space
setopt hist_ignore_space

# Better history search
setopt hist_find_no_dups

# ===============================================
# Key Bindings
# ===============================================

# Completion using arrow keys (based on history)
bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward

# Better word navigation
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# ===============================================
# Zsh Plugin Management
# ===============================================

# Source zsh-syntax-highlighting
if [[ -f "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Source zsh-autosuggestions
if [[ -f "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# ===============================================
# Zsh-Specific Aliases
# ===============================================

# Reload zsh configuration
alias reload='source ~/.zshrc'
