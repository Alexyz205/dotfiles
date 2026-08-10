# Project Templates

Templates for setting up project-level dev environments with Nix.

## Quick start

```bash
cp examples/project-flake.nix /path/to/project/flake.nix
cp examples/Justfile /path/to/project/Justfile
cd /path/to/project
nix develop
```

## How it works

- **`project-flake.nix`** — defines a devShell with project-specific runtimes (node, python, go, rust), env vars, and aliases. Enter with `nix develop` or add `use flake` to `.envrc` for auto-activation with direnv.

- **`Justfile`** — project task runner (replaces mise tasks). Runs with `just <task>`.

## Why not mise anymore?

Project-specific tools are now managed via Nix devShells instead of mise. Each project declares its own dependencies in `flake.nix`. This gives reproducible environments without relying on a global tool manager.
