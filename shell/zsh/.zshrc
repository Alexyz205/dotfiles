# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# Set to superior editing mode

set -o vi

export VISUAL=nvim
export EDITOR=nvim

# Directories

export REPOS="$HOME/repos"
export GITUSER="alexyz205"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export XDG_CONFIG_HOME="$HOME/.config"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

path=(
    $path                           # Keep existing PATH entries
    $HOME/bin
    $HOME/.local/bin
    $SCRIPTS                        # Add scripts directory to PATH
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# ~~~~~~~~~~~~~~~ Load plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "Starship not found, skipping initialization."
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
else
  echo "zoxide not found, skipping initialization."
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
else
  echo "fzf not found, skipping fzf initialization."
fi

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ~~~~~~~~~~~~~~~ Tmux ~~~~~~~~~~~~~~~~~~~~~~~~

# if command -v tmux &> /dev/null; then
#   if [ -z "$TMUX" ]; then
#     echo "Starting tmux..."
#     tmux attach -t dev || tmux new-session -s dev
#   else
#     clear
#   fi
# else
#   echo "tmux not found, skipping tmux initialization."
# fi

alias t='tmux attach -t dev || tmux new-session -s dev'

# ~~~~~~~~~~~~~~~ Configurations ~~~~~~~~~~~~~~~~~

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt hist_ignore_space

# completion using arrow keys (based on history)
bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

# Repos
alias dot='cd $DOTFILES'
alias repos='cd $REPOS'

# ls
alias ls='eza --color=auto'
alias la='eza -la'
alias ll='eza -l --git -T --hyperlink --color=auto'

alias find='fd'
alias f='fzf'

# Applications
alias v=nvim
alias t='tmux'
alias r='ranger'
alias p='python'
alias k='kubectl'
alias h='helm'
alias hf='helmfile'
alias d='docker'
alias dc='docker-compose'

# Git
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias lg='lazygit'

# Additional useful aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'
alias e='exit'
alias c="clear"
alias reload='source ~/.bashrc'
alias ik8s='~/dotfiles/scripts/install_k8s'
alias da='direnv allow'

# Devpod

alias ds='devpod ssh'
alias du='devpod up .'

# Docker
alias dru='docker run -it --rm -v ~/repos/dotfiles:/root/dotfiles ubuntu bash'

# Nix
alias nr='nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/repos/dotfiles/nix#Alexis-MBA'

# SSH
alias sshhs='ssh alexyz@homeserveralexyz'
