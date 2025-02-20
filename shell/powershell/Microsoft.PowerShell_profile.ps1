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

# Yazi functions
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

# File operations with eza (function-based for complex commands)
function ls { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --color=auto --icons @args } else { Get-ChildItem @args } }
function la { if (Get-Command eza -ErrorAction SilentlyContinue) { eza -la --icons @args } else { Get-ChildItem -Force @args } }
function ll { if (Get-Command eza -ErrorAction SilentlyContinue) { eza -l --git --icons --hyperlink @args } else { Get-ChildItem -l @args } }
function lt { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --tree --level=2 --icons @args } else { tree @args } }
function lta { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --tree --level=2 --icons -a @args } else { tree @args } }
function ltl { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --tree --level=2 --icons -l @args } else { tree @args } }
function ldir { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --long --icons --only-dirs @args } else { Get-ChildItem -Directory @args } }
function lg { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --grid --icons @args } else { Get-ChildItem @args } }
function lm { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --icons --sort=modified @args } else { Get-ChildItem | Sort-Object LastWriteTime @args } }
function ld { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --icons --sort=date @args } else { Get-ChildItem | Sort-Object LastWriteTime @args } }
function lz { if (Get-Command eza -ErrorAction SilentlyContinue) { eza --icons --sort=size @args } else { Get-ChildItem | Sort-Object Length @args } }

# ===============================================
# Aliases
# ===============================================

# Repositories and navigation
Set-Alias -Name dot -Value Set-DotfilesLocation
Set-Alias -Name repos -Value Set-ReposLocation
Set-Alias -Name .. -Value Set-ParentLocation
Set-Alias -Name ... -Value Set-GrandparentLocation
Set-Alias -Name .... -Value Set-GreatGrandparentLocation

# Safe aliases with tool existence checks
if (Get-Command z -ErrorAction SilentlyContinue) {
    Set-Alias -Name cd -Value z -Option AllScope
}
if (Get-Command fd -ErrorAction SilentlyContinue) {
    Set-Alias -Name find -Value fd -Option AllScope
}
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    Set-Alias -Name f -Value fzf -Option AllScope
}

# Applications and tools
if (Get-Command nvim -ErrorAction SilentlyContinue) {
    Set-Alias -Name v -Value nvim -Option AllScope
}
if (Get-Command tmux -ErrorAction SilentlyContinue) {
    Set-Alias -Name t -Value tmux -Option AllScope
}
if (Get-Command python -ErrorAction SilentlyContinue) {
    Set-Alias -Name p -Value python -Option AllScope
}
if (Get-Command kubectl -ErrorAction SilentlyContinue) {
    Set-Alias -Name k -Value kubectl -Option AllScope
}
if (Get-Command helm -ErrorAction SilentlyContinue) {
    Set-Alias -Name h -Value helm -Option AllScope
}
if (Get-Command helmfile -ErrorAction SilentlyContinue) {
    Set-Alias -Name hf -Value helmfile -Option AllScope
}
if (Get-Command docker -ErrorAction SilentlyContinue) {
    Set-Alias -Name d -Value docker -Option AllScope
}
if (Get-Command docker-compose -ErrorAction SilentlyContinue) {
    Set-Alias -Name dc -Value docker-compose -Option AllScope
}
if (Get-Command lazydocker -ErrorAction SilentlyContinue) {
    Set-Alias -Name ld -Value lazydocker -Option AllScope
}
if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-Alias -Name lg -Value lazygit -Option AllScope
}

# Utilities
Set-Alias -Name e -Value exit -Option AllScope
Set-Alias -Name c -Value clear -Option AllScope
Set-Alias -Name reload -Value "& { . $PROFILE }" -Option AllScope
Set-Alias -Name ik8s -Value "~/dotfiles/scripts/install_k8s" -Option AllScope

# DevPod aliases
if (Get-Command devpod -ErrorAction SilentlyContinue) {
    function ds { devpod ssh @args }
    function du { devpod up . @args }
}
