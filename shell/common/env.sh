#!/bin/bash
# ===============================================
# Shared Environment Variables
# ===============================================
# Common environment configuration shared across all shells.
# This file should be sourced by shell-specific configurations.
#
# Usage: source "$SHELL_DIR/common/env.sh"

# ===============================================
# Editor Configuration
# ===============================================
export VISUAL=nvim
export EDITOR=nvim

# ===============================================
# Directory Structure
# ===============================================
export REPOS="$HOME/repos"
export GITUSER="alexyz205"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export XDG_CONFIG_HOME="$HOME/.config"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# ===============================================
# Ollama GPU Optimization
# ===============================================
# GPU Configuration for Ollama (RTX 4090)
export OLLAMA_GPU_LAYERS=99999          # Use all layers on GPU
export OLLAMA_NUM_GPU=1                 # Use 1 GPU
export CUDA_VISIBLE_DEVICES=0           # Use GPU 0
export OLLAMA_NUM_PARALLEL=4            # Allow concurrent requests
export OLLAMA_MAX_LOADED_MODELS=2       # Keep multiple models loaded
export OLLAMA_CONTEXT_SIZE=8192         # Optimize context size for RTX 4090

# ===============================================
# Tmux Configuration
# ===============================================
# Set to 1 to enable automatic tmux session management
# Set to 0 to disable automatic tmux startup
export TMUX_AUTO_START="${TMUX_AUTO_START:-1}"
