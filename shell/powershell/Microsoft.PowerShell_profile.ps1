# ===============================================
# Environment Variables and Core Settings
# ===============================================
$ENV:REPOS = "X:\repos"
$ENV:DOTFILES = "$ENV:REPOS\dotfiles"
$ENV:STARSHIP_CONFIG = "X:\repos\dotfiles\starship.toml"
$ENV:EZA_CONFIG_DIR = "$ENV:USERPROFILE\.config\eza"

# ===============================================
# Tool Initializations
# ===============================================
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# ===============================================
# Functions
# ===============================================

# Navigation functions
function Set-DotfilesLocation { Set-Location $ENV:DOTFILES }
function Set-ReposLocation { Set-Location $ENV:REPOS }
function Set-ParentLocation { Set-Location .. }
function Set-GrandparentLocation { Set-Location ../.. }
function Set-GreatGrandparentLocation { Set-Location ../../.. }

# Git functions
function Get-GitStatus { git status }
function Add-GitChanges { git add $args }
function New-GitCommit { git commit $args }
function New-GitCommitWithMessage { git commit -m $args }
function Set-GitBranch { git checkout $args }
function Get-GitDiff { git diff $args }
function Get-GitLog { git log $args }
function Push-GitChanges { git push $args }
function Pull-GitChanges { git pull $args }

# Kubernetes functions
function Get-KubernetesContext { kubectl config current-context }

# ===============================================
# Aliases
# ===============================================

# Repositories and navigation
Set-Alias -Name dot -Value Set-DotfilesLocation
Set-Alias -Name repos -Value Set-ReposLocation
Set-Alias -Name .. -Value Set-ParentLocation
Set-Alias -Name ... -Value Set-GrandparentLocation
Set-Alias -Name .... -Value Set-GreatGrandparentLocation
Set-Alias -Name cd -Value "z" -Option AllScope

# File operations with eza
Set-Alias -Name ls -Value "eza --color=auto --icons" -Option AllScope
Set-Alias -Name la -Value "eza -la --icons" -Option AllScope
Set-Alias -Name ll -Value "eza -l --git --icons --hyperlink" -Option AllScope
Set-Alias -Name lt -Value "eza --tree --level=2 --icons" -Option AllScope
Set-Alias -Name lta -Value "eza --tree --level=2 --icons -a" -Option AllScope
Set-Alias -Name ltl -Value "eza --tree --level=2 --icons -l" -Option AllScope
Set-Alias -Name ldir -Value "eza --long --icons --only-dirs" -Option AllScope
Set-Alias -Name lg -Value "eza --grid --icons" -Option AllScope
Set-Alias -Name lm -Value "eza --icons --sort=modified" -Option AllScope
Set-Alias -Name ld -Value "eza --icons --sort=date" -Option AllScope
Set-Alias -Name lz -Value "eza --icons --sort=size" -Option AllScope
Set-Alias -Name find -Value fd -Option AllScope
Set-Alias -Name f -Value fzf -Option AllScope

# Applications and tools
Set-Alias -Name v -Value nvim -Option AllScope
Set-Alias -Name t -Value tmux -Option AllScope
Set-Alias -Name y -Value yazi -Option AllScope
Set-Alias -Name p -Value python -Option AllScope
Set-Alias -Name k -Value kubectl -Option AllScope
Set-Alias -Name h -Value helm -Option AllScope
Set-Alias -Name hf -Value helmfile -Option AllScope
Set-Alias -Name d -Value docker -Option AllScope
Set-Alias -Name dc -Value docker-compose -Option AllScope
Set-Alias -Name ld -Value lazydocker -Option AllScope
Set-Alias -Name lg -Value lazygit -Option AllScope

# Utilities
Set-Alias -Name e -Value exit -Option AllScope
Set-Alias -Name c -Value clear -Option AllScope
Set-Alias -Name reload -Value "& { . $PROFILE }" -Option AllScope
Set-Alias -Name ik8s -Value "~/dotfiles/scripts/install_k8s" -Option AllScope
Set-Alias -Name da -Value "direnv allow" -Option AllScope

# DevPod aliases
Set-Alias -Name ds -Value "devpod ssh" -Option AllScope
Set-Alias -Name du -Value "devpod up ." -Option AllScope
