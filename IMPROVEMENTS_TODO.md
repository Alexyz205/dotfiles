# Dotfiles Improvement TODO List

This file contains actionable improvements for the dotfiles repository. Each item is designed to be implemented by an LLM agent with clear instructions and implementation details.

## 🚀 **Priority 1: Structure & Organization**

### ✅ TODO 1.1: Centralize Configuration Management
**Status:** Not Started
**Priority:** High
**Estimated Time:** 30 minutes

**Description:**
Move scattered configuration files to follow XDG Base Directory specification.

**Current State:**
- `starship.toml` in root
- `yazi/*` in root/yazi
- `lazygit-config.yml` in root
- `eza-theme-catppuccin.yml` in root

**Implementation Steps:**
1. Create XDG config structure: `mkdir -p config/{starship,yazi,lazygit,eza}`
2. Move `starship.toml` → `config/starship/starship.toml`
3. Move `yazi/*` → `config/yazi/`
4. Move `lazygit-config.yml` → `config/lazygit/config.yml`
5. Move `eza-theme-catppuccin.yml` → `config/eza/theme.yml`
6. Update `scripts/setup` to create proper symlinks to `~/.config/`
7. Update any references in shell configs

**Files to Modify:**
- `scripts/setup`
- `shell/zsh/.zshrc` (line 18: EZA_CONFIG_DIR)
- Move files as described above

### ✅ TODO 1.2: Add Installation Validation Script
**Status:** Not Started  
**Priority:** High  
**Estimated Time:** 45 minutes

**Description:**
Create a comprehensive validation script to verify all tools are properly installed and configured.

**Implementation:**
Create `scripts/validate` with the following features:
- Check if all required tools are installed
- Verify configuration files exist and are valid
- Test symlinks are working
- Validate theme consistency across tools
- Check for common configuration issues

**Required Functions:**
```bash
check_tool() { ... }           # Verify tool installation
validate_config() { ... }     # Check config file syntax
check_symlinks() { ... }      # Verify symlink integrity
validate_theme() { ... }      # Check theme consistency
generate_report() { ... }     # Create validation report
```

**Success Criteria:**
- Script returns 0 if all validations pass
- Detailed error messages for failures
- Option to fix common issues automatically

---

## 📦 **Priority 2: Package Management**

### ✅ TODO 2.1: Create Package Version Lock File
**Status:** Not Started  
**Priority:** Medium  
**Estimated Time:** 20 minutes

**Description:**
Create a version lock file to ensure reproducible installations.

**Implementation:**
1. Create `packages.lock.yml` with current tool versions
2. Update `scripts/install_packages` to read from lock file
3. Add version checking before installation
4. Create `scripts/update_packages` to manage version updates

**Lock File Format:**
```yaml
# packages.lock.yml
version: "1.0"
last_updated: "2024-01-15"
packages:
  cli_tools:
    starship: "1.16.0"
    lazygit: "0.51.1"
    bat: "0.25.0"
    eza: "0.20.21"
    # ... etc
  brew_casks:
    ghostty: "latest"
    docker: "latest"
    # ... etc
```

### ✅ TODO 2.2: Add Backup and Rollback System
**Status:** Not Started  
**Priority:** Medium  
**Estimated Time:** 40 minutes

**Description:**
Implement backup system to safely rollback configurations.

**Implementation:**
1. Create `scripts/backup` script
2. Create `scripts/restore` script  
3. Integrate backup calls into installation scripts
4. Add backup validation and cleanup

**Backup Features:**
- Timestamp-based backup directories
- Selective backup (configs only vs full backup)
- Backup validation and integrity checks
- Automatic cleanup of old backups (keep last 5)

---

## 🔧 **Priority 3: Configuration Improvements**

### ✅ TODO 3.1: Implement Environment-Specific Configurations
**Status:** Not Started  
**Priority:** Medium  
**Estimated Time:** 60 minutes

**Description:**
Split shell configurations to support different environments (work, personal, local).

**Current Issue:**
Single `.zshrc` with hardcoded values and no environment separation.

**Implementation:**
1. Create modular zsh configuration structure:
   ```
   shell/zsh/
   ├── .zshrc              # Main loader
   ├── config/
   │   ├── base.zsh        # Common settings
   │   ├── aliases.zsh     # All aliases
   │   ├── functions.zsh   # Custom functions
   │   ├── exports.zsh     # Environment variables
   │   └── completions.zsh # Completion settings
   ├── environments/
   │   ├── work.zsh        # Work-specific config
   │   ├── personal.zsh    # Personal settings
   │   └── local.zsh.template  # Local overrides template
   ```

2. Update main `.zshrc` to source modular files
3. Add environment detection logic
4. Create local configuration template

---

## 🛠️ **Priority 4: Development Workflow**

### ✅ TODO 4.1: Add Pre-commit Hooks
**Status:** Not Started  
**Priority:** Low  
**Estimated Time:** 25 minutes

**Description:**
Implement pre-commit hooks to maintain code quality.

**Implementation:**
1. Create `.pre-commit-config.yaml`
2. Add hooks for:
   - YAML syntax validation
   - Shell script linting (shellcheck)
   - Trailing whitespace removal
   - End-of-file fixer
   - Nix file formatting
3. Update installation script to install pre-commit
4. Add pre-commit installation to setup process

### ✅ TODO 4.2: Improve Error Handling in Scripts
**Status:** Not Started  
**Priority:** Medium  
**Estimated Time:** 45 minutes

**Description:**
Add comprehensive error handling and recovery mechanisms to installation scripts.

**Current Issues:**
- Limited error recovery in `install` and `setup_dotfiles`
- No cleanup on failed installations
- Inconsistent error reporting

**Implementation:**
1. Add trap handlers for cleanup in all scripts
2. Implement rollback mechanisms
3. Add progress indicators with error states
4. Standardize error codes and messages
5. Add retry logic for network operations

**Scripts to Update:**
- `install`
- `setup_dotfiles`
- `scripts/install_packages`
- `scripts/install_k8s`
- `scripts/install_nvim`

---

## 📝 **Priority 5: Documentation & Automation**

### ✅ TODO 5.1: Create Automated Update System
**Status:** Not Started  
**Priority:** Low  
**Estimated Time:** 50 minutes

**Description:**
Create automated scripts for updating tools and maintaining the system.

**Implementation:**
Create the following scripts:

1. `scripts/update_tools` - Update all CLI tools
2. `scripts/update_configs` - Pull latest config templates
3. `scripts/check_health` - System health monitoring
4. `scripts/cleanup` - Clean temporary files and old backups

**Features:**
- Check for tool updates against version lock file
- Update brew packages safely
- Validate configurations after updates
- Generate update reports

---

## 🔒 **Priority 6: Security Enhancements**

### ✅ TODO 6.1: Implement Secrets Management
**Status:** Not Started  
**Priority:** High  
**Estimated Time:** 30 minutes

**Description:**
Add proper secrets management and template system.

**Current Issues:**
- SSH config hardcoded in zsh aliases
- No template system for sensitive configs

**Implementation:**
1. Update `.gitignore` to exclude sensitive files:
   ```
   **/.env.local
   **/secrets.yml
   ssh/config.local
   git/config.local
   ```

2. Create template files:
   - `ssh/config.template`
   - `git/config.template`

3. Add secrets setup script: `scripts/setup_secrets`

### ✅ TODO 6.2: Create SSH Configuration Template
**Status:** Not Started  
**Priority:** Low  
**Estimated Time:** 15 minutes

**Description:**
Template-based SSH configuration for different environments.

**Implementation:**
1. Create `ssh/config.template`
2. Add placeholder replacement system
3. Update setup script to generate SSH config
4. Document SSH setup process

---

## ⚡ **Quick Wins - Priority Fixes**

### ✅ TODO QW.1: Fix ZSH Plugin Paths
**Status:** Not Started  
**Priority:** High  
**Estimated Time:** 5 minutes

**Description:**
Fix hardcoded plugin paths in `.zshrc` lines 138-139.

**Current Code:**
```bash
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
```

**Fix:**
Use absolute paths or check if files exist before sourcing.

### ✅ TODO QW.2: Add Version Checking to Installation Scripts
**Status:** Not Started  
**Priority:** Medium  
**Estimated Time:** 10 minutes

**Description:**
Add version checking before downloading tools in installation scripts.

### ✅ TODO QW.3: Create Unified Theme Manager
**Status:** Not Started  
**Priority:** Low  
**Estimated Time:** 40 minutes

**Description:**
Centralized theme management for Catppuccin across all tools.

### ✅ TODO QW.4: Add Shell Completions for Custom Scripts
**Status:** Not Started  
**Priority:** Low  
**Estimated Time:** 30 minutes

**Description:**
Create completions for custom scripts in `scripts/completions/`.

---

## 🔄 **Implementation Order**

**Phase 1 (Essential):**
1. TODO 1.1: Centralize Configuration Management
2. TODO 1.2: Add Installation Validation Script
3. TODO QW.1: Fix ZSH Plugin Paths
4. TODO 6.1: Implement Secrets Management

**Phase 2 (Stability):**
1. TODO 2.1: Create Package Version Lock File
2. TODO 2.2: Add Backup and Rollback System
3. TODO 4.2: Improve Error Handling in Scripts

**Phase 3 (Enhancement):**
1. TODO 3.1: Implement Environment-Specific Configurations
2. TODO 5.1: Create Automated Update System
3. TODO 5.2: Add Health Check System

**Phase 4 (Polish):**
- All remaining TODO items

---

## 📋 **Notes for LLM Implementation**

### General Guidelines:
2. **Test each change incrementally**
3. **Follow existing code style and patterns**
4. **Add appropriate logging to all scripts**
5. **Update documentation as you implement**

### Code Standards:
- Use bash strict mode: `set -euo pipefail`
- Follow existing logging patterns from `scripts/logs`
- Maintain compatibility with existing setup
- Add comments for complex logic
- Use descriptive variable names

### Testing Approach:
- Test on clean environment when possible
- Verify symlinks work correctly
- Check that existing functionality still works
- Validate error handling paths

### File Permissions:
- Scripts should be executable (755)
- Config files should be readable (644)
- Maintain existing permission patterns

---

**Last Updated:** 2025-08-06  
**Version:** 1.0  
