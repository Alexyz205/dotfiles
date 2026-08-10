# ─────────────────────────────────────────────────────
# Project devShell template
# ─────────────────────────────────────────────────────
# Copy this to your project root as flake.nix.
# Then run:    nix develop
# Or with direnv:   echo "use flake" > .envrc && direnv allow
#
# ─────────────────────────────────────────────────────
{
  description = "Project dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        # ── Runtimes & packages ──────────────────────
        packages = with pkgs; [
          # Languages
          nodejs_22
          python3
          go
          rustc
          cargo

          # Tools
          just               # task runner
          direnv             # auto-env loading
          jq
          yq
        ];

        # ── Environment variables ────────────────────
        PROJECT_ROOT = toString ./.;  # project root path
        LOG_LEVEL = "debug";
        FOO_VAR = "bar";

        # ── Aliases (injected via shellHook) ──────────
        shellHook = ''
          # Aliases
          alias ll='ls -la'
          alias gst='git status'
          alias glog='git log --oneline --graph'

          # Custom prompt prefix
          export PS1="(project) $PS1"

          echo "Project dev shell ready"
        '';
      };
    };
}
