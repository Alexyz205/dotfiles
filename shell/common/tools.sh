#!/bin/bash
# ===============================================
# Tool Initializations
# ===============================================
# Common tool initialization commands shared across all shells.
# This file handles tool initialization for mise, starship, zoxide, and television
# with automatic shell detection.
#
# Usage: source "$SHELL_DIR/common/tools.sh"

# ===============================================
# Mise (Tool Version Manager)
# ===============================================
# Activate mise early to make tools and environment variables available

# First, ensure mise binary is in PATH
if [ ! -x "$(command -v mise 2>/dev/null)" ] && [ -x "$HOME/.local/bin/mise" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Add mise shims directory to PATH for non-interactive/devcontainer environments
if [ -d "$HOME/.local/share/mise/shims" ]; then
  if [[ ":$PATH:" != *":$HOME/.local/share/mise/shims:"* ]]; then
    export PATH="$HOME/.local/share/mise/shims:$PATH"
  fi
fi

if command -v mise &>/dev/null; then
  # Determine the current shell and activate mise
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
# Television (Fuzzy Finder)
# ===============================================
# Initialize television shell integration if available
if command -v tv &>/dev/null; then
  export TV_AVAILABLE=1
  # Shell-specific initialization
  if [ -n "$ZSH_VERSION" ]; then
    eval "$(tv init zsh)" 2>/dev/null || true
    # Override Ctrl+T to avoid zsh "do you wish to see all N possibilities"
    # when prompt is empty - launch tv files channel instead of expand-or-complete
    _tv_smart_autocomplete() {
      _disable_bracketed_paste
      local tokens prefix lbuf
      setopt localoptions noshwordsplit noksh_arrays noposixbuiltins
      tokens=(${(z)LBUFFER})
      if [ ${#tokens} -lt 1 ]; then
        local output
        output=$(tv files --no-status-bar --inline)
        zle reset-prompt
        if [[ -n $output ]]; then
          LBUFFER="${LBUFFER}${output}"
        fi
        _enable_bracketed_paste
        return
      fi
      [[ ${LBUFFER[-1]} == ' ' ]] && tokens+=("")
      if [[ ${LBUFFER} = *"${tokens[-2]-}${tokens[-1]}" ]]; then
        tokens[-2]="${tokens[-2]-}${tokens[-1]}"
        tokens=(${tokens[0,-2]})
      fi
      lbuf=$LBUFFER
      prefix=${tokens[-1]}
      [ -n "${tokens[-1]}" ] && lbuf=${lbuf:0:-${#tokens[-1]}}
      __tv_path_completion "$prefix" "$lbuf"
      _enable_bracketed_paste
    }
    # Override Ctrl+R history to use cable channel with dedup
    _tv_shell_history() {
      emulate -L zsh
      zle -I
      _disable_bracketed_paste
      local current_prompt=$LBUFFER
      local output
      output=$(tv zsh-history --no-status-bar --input "$current_prompt" --inline)
      zle reset-prompt
      if [[ -n $output ]]; then
        RBUFFER=""
        LBUFFER="$output"
      fi
      _enable_bracketed_paste
    }
  elif [ -n "$BASH_VERSION" ]; then
    eval "$(tv init bash)" 2>/dev/null || true
    # Override Ctrl+T to launch tv files channel on empty prompt
    tv_smart_autocomplete() {
      _disable_bracketed_paste
      local tokens prefix lbuf
      local current_prompt="${READLINE_LINE:0:$READLINE_POINT}"
      read -ra tokens <<< "$current_prompt"
      if [[ ${#tokens[@]} -lt 1 ]]; then
        local output
        printf "\n"
        output=$(tv files --no-status-bar --inline)
        if [[ -n "$output" ]]; then
          READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${output}"
          READLINE_POINT=$(( READLINE_POINT + ${#output} ))
        fi
        printf "\033[A"
        _enable_bracketed_paste
        return
      fi
      [[ "${READLINE_LINE:$((READLINE_POINT-1)):1}" == " " ]] && tokens+=("")
      prefix="${tokens[-1]}"
      if [[ -n "$prefix" ]]; then
        lbuf="${current_prompt:0:$((${#current_prompt} - ${#prefix}))}"
      else
        lbuf="$current_prompt"
      fi
      __tv_path_completion "$prefix" "$lbuf"
      _enable_bracketed_paste
    }
    # Override Ctrl+R history to use cable channel with dedup
    tv_shell_history() {
      _disable_bracketed_paste
      local current_prompt="${READLINE_LINE:0:$READLINE_POINT}"
      local output
      printf "\n"
      output=$(tv bash-history --no-status-bar --input "$current_prompt" --inline)
      if [[ -n "$output" ]]; then
        READLINE_LINE="$output"
        READLINE_POINT=${#READLINE_LINE}
      fi
      printf "\033[A"
      _enable_bracketed_paste
    }
  fi
else
  echo "tv (television) not found, skipping television initialization."
  export TV_AVAILABLE=0
fi
