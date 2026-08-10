set shell := ["bash", "-uc"]

# ===============================================
# Dotfiles (Nix + home-manager)
# ===============================================
# Replaces the old mise task runner.

# --- Project lifecycle (mise task parity) ---
clean: ## Clean nix store garbage and optimise
    nix-collect-garbage -d
    nix store optimise

test: ## Run all checks
    nix flake check

build: ## Build home-manager activation package
    home-manager --extra-experimental-features 'nix-command flakes' build --flake .

deploy: ## Deploy home configuration
    home-manager --extra-experimental-features 'nix-command flakes' switch --flake .

dev: ## Enter the dev shell
    nix develop

# --- Convenience ---
switch: ## Build + activate home-manager config
    home-manager --extra-experimental-features 'nix-command flakes' switch --flake .

update: ## Update flake inputs
    nix --extra-experimental-features 'nix-command flakes' flake update

gc: ## Garbage collect without deleting old generations
    nix-collect-garbage
