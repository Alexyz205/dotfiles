#!/bin/bash
# ===============================================
# Shared Functions
# ===============================================
# Common shell functions shared across all shells.
# This file should be sourced by shell-specific configurations.
#
# Usage: source "$SHELL_DIR/common/functions.sh"

# ===============================================
# Yazi Shell Wrapper
# ===============================================
# Allows yazi to change the current directory when exiting
# Usage: y [directory]
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if [ -f "$tmp" ]; then
		IFS= read -r -d '' cwd < "$tmp" || cwd="$(cat "$tmp")"
		[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
		rm -f -- "$tmp"
	fi
}

# ===============================================
# Clipboard Functions (OSC 52 via tmux, X11 fallback)
# ===============================================
# In tmux: uses tmux load-buffer which propagates to system clipboard
#   via built-in OSC 52 support (set-clipboard on in tmux.conf)
# Outside tmux: falls back to xclip/xsel

# Copy stdin to system clipboard
function pbcopy() {
  if [ -n "${TMUX:-}" ]; then
    tmux load-buffer -
  elif command -v xclip &>/dev/null; then
    command xclip -selection clipboard
  elif command -v xsel &>/dev/null; then
    command xsel --clipboard --input
  else
    cat >/dev/null
  fi
}

# ===============================================
# Tmux Auto-Start Function
# ===============================================
# Automatically attaches to or creates a tmux session
# Respects TMUX_AUTO_START environment variable
function tmux_auto_start() {
	# Skip if TMUX_AUTO_START is disabled
	if [ "${TMUX_AUTO_START:-1}" = "0" ]; then
		return 0
	fi

	# Skip if tmux is not available
	if ! command -v tmux &>/dev/null; then
		echo "tmux not found, skipping tmux initialization."
		return 1
	fi

	# Skip if already inside tmux
	if [ -n "$TMUX" ]; then
		clear
		return 0
	fi

	# Only run in interactive terminals
	if ! [[ -o interactive ]] || ! test -t 0; then
		return 1
	fi

	# Attach to existing session or create new one (atomic)
	echo "Starting tmux..."
	tmux new-session -A -s dev
}
