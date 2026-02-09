# Shell Configuration

> Modular shell configuration with shared components across Bash, Zsh, and PowerShell.

## Architecture

This shell configuration follows **Clean Architecture** principles with a modular, DRY (Don't Repeat Yourself) design. Shared configurations are extracted into reusable modules, while shell-specific features remain separate.

```
shell/
├── common/                          # Shared configurations
│   ├── env.sh                       # Environment variables
│   ├── aliases.sh                   # Aliases (tool-agnostic)
│   ├── functions.sh                 # Shared functions
│   ├── fzf.sh                       # FZF configuration
│   └── tools.sh                     # Tool initializations
├── bash/
│   ├── .bashrc                      # Main Bash config (sources common)
│   └── bash_specific.sh             # Bash-only features
├── zsh/
│   ├── .zshrc                       # Main Zsh config (sources common)
│   ├── .zprofile                    # Platform-specific (macOS)
│   ├── zsh_specific.sh              # Zsh-only features
│   └── plugins/                     # Zsh plugins
│       ├── zsh-autosuggestions/     # Git submodule
│       └── zsh-syntax-highlighting/ # Git submodule
└── powershell/
    └── Microsoft.PowerShell_profile.ps1
```

## Design Principles

### 1. **Single Source of Truth**
Common configurations (environment variables, aliases, functions) are defined once in `common/` and sourced by all shells.

### 2. **Separation of Concerns**
- **Common Layer**: Cross-shell configurations
- **Shell-Specific Layer**: Features unique to each shell
- **Clear Boundaries**: Each module has a single, well-defined purpose

### 3. **DRY (Don't Repeat Yourself)**
No code duplication between shell configurations. Shared logic lives in `common/`.

### 4. **Modularity**
Each configuration file is a standalone module that can be:
- Sourced independently
- Modified without affecting other modules
- Tested in isolation

### 5. **Fail-Safe Design**
- Graceful degradation when tools are missing
- Clear error messages for debugging
- No silent failures

## Configuration Modules

### Common Modules

#### `common/env.sh`
Environment variables shared across all shells:
- Editor configuration (`VISUAL`, `EDITOR`)
- Directory structure (`REPOS`, `DOTFILES`, `SCRIPTS`)
- Tool-specific settings (Ollama GPU, XDG directories)
- Feature flags (`TMUX_AUTO_START`)

#### `common/aliases.sh`
Shell-agnostic command aliases:
- Navigation shortcuts (`dot`, `repos`, `..`)
- Modern tool replacements (`eza` for `ls`)
- Git shortcuts (`g`, `ga`, `gc`, `gp`)
- Container/Kubernetes (`k`, `d`, `h`)
- DevOps tools (`da`, `ik8s`)

#### `common/functions.sh`
Shared shell functions:
- `y()` - Yazi file manager wrapper with directory changing
- `tmux_auto_start()` - Automated tmux session management

#### `common/fzf.sh`
FZF (Fuzzy Finder) configuration:
- Catppuccin Mocha theme
- CTRL-T file search with `bat` preview
- CTRL-R history search with copy-to-clipboard
- ALT-C directory navigation

#### `common/tools.sh`
Tool availability detection and initialization:
- Mise (version manager)
- Starship prompt
- Zoxide (smart cd)
- FZF integration

### Shell-Specific Modules

#### Bash (`bash/bash_specific.sh`)
Bash-only features:
- Shell options (`histappend`, `checkwinsize`, `extglob`)
- Programmable completion
- History configuration
- Key bindings (arrow key history search)
- Bash-specific tool initializations

#### Zsh (`zsh/zsh_specific.sh`)
Zsh-only features:
- Extended globbing and corrections
- Advanced completion system with caching
- Zsh-style PATH management
- Plugin loading (syntax highlighting, autosuggestions)
- History sharing between sessions
- Enhanced key bindings

## Customization

### Adding New Shared Configurations

To add a new shared configuration module:

1. Create a new file in `common/`:
   ```bash
   touch shell/common/my_config.sh
   ```

2. Add your configuration with a clear header:
   ```bash
   #!/bin/bash
   # ===============================================
   # My Custom Configuration
   # ===============================================
   # Description of what this module does
   
   # Your configuration here
   ```

3. Source it in `.bashrc` and `.zshrc`:
   ```bash
   if [ -f "$SHELL_DIR/common/my_config.sh" ]; then
     source "$SHELL_DIR/common/my_config.sh"
   fi
   ```

### Adding Shell-Specific Features

To add features specific to one shell:

1. Edit the appropriate `*_specific.sh` file:
   - `bash/bash_specific.sh` for Bash-only features
   - `zsh/zsh_specific.sh` for Zsh-only features

2. Add your configuration in the relevant section

### Disabling Features

#### Disable Tmux Auto-Start
Add to your environment (before sourcing shell configs):
```bash
export TMUX_AUTO_START=0
```

#### Disable Tool Initialization
The configuration gracefully handles missing tools. If a tool isn't installed, its initialization is skipped automatically.

## Features

### Vi Mode
Both Bash and Zsh are configured with Vi key bindings by default.

### FZF Integration
- **CTRL-T**: Fuzzy file search with preview
- **CTRL-R**: Command history search
- **ALT-C**: Directory navigation
- Catppuccin Mocha theme for consistent styling

### Smart Directory Navigation
- `z <partial-path>` - Jump to frequently used directories (zoxide)
- `y` - Open Yazi file manager and change to selected directory
- `.`, `..`, `...`, `....` - Quick parent directory navigation

### Tool-Aware Aliases
Aliases automatically adjust based on available tools:
- Uses `eza` if available, falls back to `ls`
- Provides helpful messages when tools are missing

### Automatic Environment Management
- Mise integration for per-directory tool versions
- Automatic loading of `.mise.toml` files

### Cross-Shell Consistency
Same aliases, functions, and behavior across Bash and Zsh.

## Maintenance

### Updating Configuration
After modifying shell configurations:

```bash
# Reload current shell
source ~/.bashrc  # or source ~/.zshrc

# Or reload alias
reload
```

### Testing Changes
Test configurations in a clean environment:

```bash
# Start a new subshell
bash  # or zsh

# Test your changes
# Exit when done
exit
```

### Debugging
Enable verbose output to debug configuration loading:

```bash
# Add to the top of .bashrc or .zshrc
set -x

# Run your shell
# Check output for errors

# Disable when done
set +x
```

## Performance

### Load Time Optimization
The modular architecture allows for:
- Lazy loading of heavy tools
- Conditional feature enablement
- Faster shell startup times

### Plugin Management
Zsh plugins are loaded only after core configurations to ensure:
- Faster initialization
- Proper dependency order
- Graceful failure handling

## Best Practices

### DO:
- ✅ Keep shared logic in `common/`
- ✅ Use feature flags for optional functionality
- ✅ Check tool availability before using
- ✅ Document configuration changes
- ✅ Test in both Bash and Zsh

### DON'T:
- ❌ Duplicate code between shells
- ❌ Hardcode absolute paths (use variables)
- ❌ Assume tools are installed
- ❌ Mix shell-specific syntax in common files
- ❌ Source configurations multiple times

## Troubleshooting

### Common Issues

#### Plugins Not Loading
**Problem**: Zsh plugins (syntax highlighting, autosuggestions) not working

**Solution**:
```bash
# Ensure plugins are in the correct location
ls $XDG_CONFIG_HOME/zsh/plugins/

# Re-run setup to fix symlinks
cd ~/repos/dotfiles
./setup_dotfiles
```

#### PATH Not Set Correctly
**Problem**: Commands not found after sourcing configuration

**Solution**:
```bash
# Check SHELL_DIR is set correctly
echo $SHELL_DIR

# Verify common/env.sh is being sourced
grep "common/env.sh" ~/.zshrc
```

#### Tool Initialization Failing
**Problem**: Starship/Zoxide/Mise not initializing

**Solution**:
```bash
# Check if tool is installed
command -v starship
command -v zoxide
command -v mise

# Install missing tools
cd ~/repos/dotfiles
./scripts/install_packages
```

## Migration from Old Configuration

If you have an existing shell configuration:

1. **Backup your current config**:
   ```bash
   cp ~/.zshrc ~/.zshrc.backup
   cp ~/.bashrc ~/.bashrc.backup
   ```

2. **Run the setup script**:
   ```bash
   cd ~/repos/dotfiles
   ./setup_dotfiles
   ```

3. **Restart your shell**:
   ```bash
   exec zsh  # or exec bash
   ```

4. **Verify everything works**:
   ```bash
   # Check environment variables
   echo $DOTFILES
   echo $SCRIPTS
   
   # Test aliases
   dot  # Should cd to dotfiles directory
   
   # Test tools
   starship --version
   zoxide --version
   ```

## Contributing

When contributing shell configurations:

1. Follow the modular architecture
2. Keep common logic in `common/`
3. Document new features in this README
4. Test in both Bash and Zsh
5. Ensure backwards compatibility

## License

Part of the dotfiles repository. See root LICENSE file.

---

**Last Updated**: 2025-01-14  
**Version**: 3.0  
**Maintainer**: Alexis
