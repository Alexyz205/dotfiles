#!/bin/bash
# ===============================================
# Bash-Specific Configuration
# ===============================================
# Configuration specific to Bash shell.
# This file contains Bash-only features and optimizations.
#
# This file is sourced by .bashrc

# ===============================================
# Bash Options
# ===============================================

# Enable history appending instead of overwriting
shopt -s histappend

# Check window size after each command
shopt -s checkwinsize

# Enable extended pattern matching
shopt -s extglob

# Enable case-insensitive globbing
shopt -s nocaseglob

# Correct minor directory spelling errors
shopt -s cdspell

# ===============================================
# Bash Completion
# ===============================================

# Enable programmable completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Enable bash completion in macOS
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# ===============================================
# History Configuration
# ===============================================

HISTFILE=~/.bash_history
HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="&:ls:cd:cd -:pwd:exit:date:* --help"

# Update history after each command
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ===============================================
# Key Bindings
# ===============================================

# Completion using arrow keys (based on history)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ===============================================
# Bash-Specific Aliases
# ===============================================

# Reload bash configuration
alias reload='source ~/.bashrc'
