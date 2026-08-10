#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="dotfiles-install"
REPO_URL="https://github.com/Alexyz205/dotfiles.git"
DOTFILES_DIR="${HOME}/repos/personal/dotfiles"
NIX_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nix"

# ---- Logging ----
log()    { echo "[$(date +'%H:%M:%S')][INFO] $*"; }
success(){ echo "[$(date +'%H:%M:%S')][OK]   $*"; }
warn()   { echo "[$(date +'%H:%M:%S')][WARN] $*" >&2; }
error()  { echo "[$(date +'%H:%M:%S')][ERROR] $*" >&2; }

cleanup() { true; }
trap cleanup EXIT INT TERM

# ---- Nix installation ----
install_nix() {
  if command -v nix &>/dev/null; then
    log "Nix already installed ($(nix --version 2>/dev/null))"
    return 0
  fi
  log "Installing Nix (determinate systems installer)..."
  curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  success "Nix installed"
}

# ---- Clone / update dotfiles ----
clone_dotfiles() {
  if [ -d "$DOTFILES_DIR/.git" ]; then
    log "Updating existing dotfiles repo..."
    git -C "$DOTFILES_DIR" pull --rebase --autostash
  else
    log "Cloning dotfiles..."
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone "$REPO_URL" "$DOTFILES_DIR"
  fi
  # Init submodules (nvim)
  git -C "$DOTFILES_DIR" submodule update --init --recursive
  success "Dotfiles ready at $DOTFILES_DIR"
}

# ---- Enable nix-command + flakes (user-level nix.conf) ----
enable_flakes() {
  mkdir -p "$NIX_CONFIG_DIR"
  if [ ! -f "$NIX_CONFIG_DIR/nix.conf" ] || ! grep -q "experimental-features" "$NIX_CONFIG_DIR/nix.conf" 2>/dev/null; then
    cat >> "$NIX_CONFIG_DIR/nix.conf" <<'EOF'
experimental-features = nix-command flakes
max-jobs = auto
EOF
    success "Flakes enabled in ~/.config/nix/nix.conf"
  fi
}

# ---- Build + activate home-manager ----
activate_hm() {
  cd "$DOTFILES_DIR"
  local hm_user="alexis.pigeon"
  log "Building home-manager configuration (user: ${hm_user})..."
  nix --extra-experimental-features "nix-command flakes" build \
    --max-jobs 4 \
    ".#homeConfigurations.\"${hm_user}\".activationPackage"
  log "Activating..."
  ./result/activate
  success "Home-manager activated"
}

# ---- Post-install hints ----
print_done() {
  echo ""
  echo "  ┌────────────────────────────────────────────────────┐"
  echo "  │  Dotfiles installed!                               │"
  echo "  │                                                    │"
  echo "  │  Restart your shell or run:  exec zsh              │"
  echo "  │                                                    │"
  echo "  │  Useful commands:                                  │"
  echo "  │    just switch     Build + activate HM             │"
  echo "  │    just update     Update flake inputs             │"
  echo "  │    nix develop     Enter dev shell                 │"
  echo "  └────────────────────────────────────────────────────┘"
}

# ---- Main ----
main() {
  section_header "Dotfiles Installer"
  install_nix
  clone_dotfiles
  enable_flakes
  activate_hm
  print_done
}

section_header() {
  echo ""
  echo "===== $* ====="
}

main "$@"
