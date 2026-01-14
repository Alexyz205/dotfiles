#!/bin/bash
# ===============================================
# FZF Configuration
# ===============================================
# Fuzzy finder configuration shared across all shells.
# This file should be sourced by shell-specific configurations.
#
# Usage: source "$SHELL_DIR/common/fzf.sh"

# ===============================================
# FZF Default Options (Catppuccin Mocha Theme)
# ===============================================
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#cdd6f4,fg+:#d0d0d0,bg:#1e1e2e,bg+:#313244
  --color=hl:#89b4fa,hl+:#5fd7ff,info:#cba6f7,marker:#a6e3a1
  --color=prompt:#94e2d5,spinner:#f5c2e7,pointer:#f5c2e7,header:#87afaf
  --color=border:#f5c2e7,preview-border:#89b4fa,preview-label:#cba6f7,label:#cdd6f4
  --color=query:#a6e3a1
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="1,2"
  --prompt="◆" --marker=">" --pointer=">" --separator="─"
  --scrollbar="│" --layout="reverse"'

# ===============================================
# FZF CTRL-T Configuration (File Search)
# ===============================================
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# ===============================================
# FZF CTRL-R Configuration (History Search)
# ===============================================
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | if [[ \"\$OSTYPE\" == \"darwin\"* ]]; then pbcopy; else xclip -sel clip; fi)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# ===============================================
# FZF ALT-C Configuration (Directory Search)
# ===============================================
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"
