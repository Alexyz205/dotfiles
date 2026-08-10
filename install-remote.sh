#!/bin/bash
set -euo pipefail

# ===============================================
# Dotfiles Remote Installer
# ===============================================
# One script, two modes:
#
#   Host mode (default)  — installs the dotfiles on one or more remote
#                          hosts over SSH, by re-running this same script
#                          remotely in local mode.
#   Local mode (--local) — clones (or updates) the dotfiles repo,
#                          initializes submodules, then runs ./install.
#
# Usage:
#   ./install-remote.sh [user@]host [host2 ...]   # remote install over SSH
#   bash <(curl -fsSL <install-remote.sh URL>)    # local install from scratch
#
# Remote install:
#   - Uses your ~/.ssh/config for user/port (host can be an ssh config alias)
#   - Allocates a remote TTY so you can type the sudo password when prompted
#   - Does NOT use SSH agent forwarding; dotfiles are cloned over HTTPS
#   - Safe to re-run (idempotent)
#
# Overridable environment variables:
#   INSTALL_SCRIPT_URL  URL to fetch this script on the remote
#   DOTFILES_DIR        Install location (default: ~/repos/personal/dotfiles)
#   DOTFILES_REPO       Repo URL       (default: https://github.com/Alexyz205/dotfiles.git)
#   DOTFILES_BRANCH     Branch         (default: main)
#
# Author: Alexis
# Version: 3.0

INSTALL_SCRIPT_URL="${INSTALL_SCRIPT_URL:-https://raw.githubusercontent.com/Alexyz205/dotfiles/main/install-remote.sh}"
REPO_URL="${DOTFILES_REPO:-https://github.com/Alexyz205/dotfiles.git}"
BRANCH="${DOTFILES_BRANCH:-main}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/repos/personal/dotfiles}"

# ===============================================
# Minimal self-contained logging
# ===============================================

get_timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log()           { echo "[$(get_timestamp)][INFO] $1"; }
log_progress()  { echo "[$(get_timestamp)][PROGRESS] $1"; }
log_success()   { echo "[$(get_timestamp)][SUCCESS] $1"; }
log_warning()   { echo "[$(get_timestamp)][WARNING] $1"; }
log_error()     { echo "[$(get_timestamp)][ERROR] $1"; }

error_exit() {
    log_error "$1"
    exit 1
}

section_header() { echo -e "\n===== $1 =====\n"; }

usage() {
    cat <<EOF
Usage:
  $0 [user@]host [host2 ...]   Remote install over SSH
  $0 --local                   Local install (clone/update + ./install)
  $0 --help                    Show this help

Remote install:
  - Uses your ~/.ssh/config for user/port (host can be an ssh config alias)
  - Allocates a remote TTY so you can type the sudo password when prompted
  - Does NOT use SSH agent forwarding; dotfiles are cloned over HTTPS
  - Safe to re-run

Environment:
  INSTALL_SCRIPT_URL  URL to fetch this script on the remote (default: GitHub raw)
  DOTFILES_DIR        Install location (default: ~/repos/personal/dotfiles)
  DOTFILES_REPO       Repo URL       (default: https://github.com/Alexyz205/dotfiles.git)
  DOTFILES_BRANCH     Branch         (default: main)
EOF
}

# ===============================================
# Local mode: clone (or update) + submodules + install
# ===============================================

run_local_install() {
    section_header "Bootstrap Prerequisites"

    for tool in git curl tar; do
        command -v "$tool" &>/dev/null || error_exit "Required tool '$tool' not found. Install it first."
    done
    log_success "Prerequisites validated: git, curl, tar"

    # Warn when running through a plain pipe without a controlling TTY
    # (sudo inside install_packages.sh will not be able to prompt for a password)
    if [ ! -t 0 ] && [ -z "${SUDO_ASKPASS:-}" ]; then
        log_warning "No interactive terminal detected."
        log_warning "If a sudo password is required (e.g. 'pass' installation), run this instead:"
        log_warning "  bash <(curl -fsSL $INSTALL_SCRIPT_URL)"
    fi

    section_header "Dotfiles Repository"

    if [ -d "$DOTFILES_DIR/.git" ]; then
        log_progress "Existing dotfiles repo found: $DOTFILES_DIR"
        log_progress "Updating repository..."
        git -C "$DOTFILES_DIR" fetch --quiet origin
        git -C "$DOTFILES_DIR" checkout --quiet "$BRANCH"
        git -C "$DOTFILES_DIR" pull --ff-only --quiet origin "$BRANCH"
        log_success "Repository updated to latest"
    elif [ -e "$DOTFILES_DIR" ]; then
        error_exit "$DOTFILES_DIR exists but is not a git repo. Move it aside and re-run."
    else
        log_progress "Cloning dotfiles into $DOTFILES_DIR"
        mkdir -p "$(dirname "$DOTFILES_DIR")"
        git clone --quiet --branch "$BRANCH" "$REPO_URL" "$DOTFILES_DIR"
        log_success "Repository cloned"
    fi

    section_header "Git Submodules"

    log_progress "Synchronizing submodule URLs"
    git -C "$DOTFILES_DIR" submodule sync --recursive --quiet

    log_progress "Initializing submodules"
    git -C "$DOTFILES_DIR" submodule update --init --recursive

    log_success "All submodules initialized"

    section_header "Running Installer"

    exec bash "$DOTFILES_DIR/install"
}

# ===============================================
# Argument dispatch
# ===============================================

case "${1:-}" in
    --local)
        run_local_install
        exit $?
        ;;
    -h | --help)
        usage
        exit 0
        ;;
esac

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

command -v ssh >/dev/null 2>&1 || { log_error "ssh not found"; exit 1; }

# ===============================================
# Host mode: provision remote hosts over SSH
# ===============================================

failures=0

for host in "$@"; do
    echo
    log_progress "Provisioning $host"
    if ssh -t -o ForwardAgent=no "$host" "curl -fsSL '$INSTALL_SCRIPT_URL' -o /tmp/dotfiles-install.sh && bash /tmp/dotfiles-install.sh --local"; then
        log_success "$host installed successfully"
    else
        log_error "$host failed"
        failures=$((failures + 1))
    fi
done

echo
if [ "$failures" -eq 0 ]; then
    log_success "All hosts provisioned successfully"
else
    log_error "$failures host(s) failed"
    exit 1
fi
