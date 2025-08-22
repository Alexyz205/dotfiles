# ===============================================
# Environment Variables and Core Settings
# ===============================================

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
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# ===============================================
# Path Configuration
# ===============================================

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

# ===============================================
# Tool Configurations
# ===============================================

# Zsh Completion Initialization
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# FZF Configuration
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#cdd6f4,fg+:#d0d0d0,bg:#1e1e2e,bg+:#313244
  --color=hl:#89b4fa,hl+:#5fd7ff,info:#cba6f7,marker:#a6e3a1
  --color=prompt:#94e2d5,spinner:#f5c2e7,pointer:#f5c2e7,header:#87afaf
  --color=border:#f5c2e7,preview-border:#89b4fa,preview-label:#cba6f7,label:#cdd6f4
  --color=query:#a6e3a1
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="1,2"
  --prompt="◆" --marker=">" --pointer=">" --separator="─"
  --scrollbar="│" --layout="reverse"'

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | if [[ "$OSTYPE" == "darwin"* ]]; then pbcopy; else xclip -sel clip; fi)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# ===============================================
# Tool Initializations
# ===============================================

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "Starship not found, skipping initialization."
fi

# Zoxide (smart cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
else
  echo "zoxide not found, skipping initialization."
fi

# Direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
else
  echo "direnv not found, skipping initialization."
fi

# Carapace (completions)
if command -v carapace &> /dev/null; then
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
  source <(carapace _carapace)
else
  echo "carapace not found, skipping initialization."
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
else
  echo "fzf not found, skipping fzf initialization."
fi

# Yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Tmux Initialization
# Uncomment the following lines if you want to use tmux

if command -v tmux &> /dev/null; then
  if [ -z "$TMUX" ]; then
    echo "Starting tmux..."
    tmux attach -t dev || tmux new-session -s dev
  else
    clear
  fi
else
  echo "tmux not found, skipping tmux initialization."
fi

alias t='tmux attach -t dev || tmux new-session -s dev'

# Zsh plugins
if [[ -f "$XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$XDG_CONFIG_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -f "$XDG_CONFIG_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$XDG_CONFIG_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# ===============================================
# History
# ===============================================

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt hist_ignore_space

# Completion using arrow keys (based on history)
bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward

# ===============================================
# Aliases
# ===============================================

# Navigation
alias dot='cd $DOTFILES'
alias repos='cd $REPOS'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'

# File operations
if command -v eza &> /dev/null; then
  # Eza with icons and enhanced display
  alias ls='eza --color=auto --icons'
  alias la='eza -la --icons'
  alias ll='eza -l --git --icons --hyperlink'
  alias lt='eza --tree --level=2 --icons'
  alias lta='eza --tree --level=2 --icons -a'
  alias ltl='eza --tree --level=2 --icons -l'
  alias ldir='eza --long --icons --only-dirs'
  alias lg='eza --grid --icons'
  alias lm='eza --icons --sort=modified'
  alias ld='eza --icons --sort=date'
  alias lz='eza --icons --sort=size'
else
  echo "eza not found, using default ls"
fi

alias f='fzf'

# Applications
alias v='nvim'
alias t='tmux attach -t dev || tmux new-session -s dev'
alias p='python'
alias e='exit'
alias c='clear'
alias reload='source ~/.bashrc'

# Git
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias gp='git pull'
alias gP='git push'
alias gs='git status'
alias lg='lazygit'

# Container and Kubernetes
alias k='kubectl'
alias h='helm'
alias hf='helmfile'
alias d='docker'
alias dc='docker-compose'
alias ld='lazydocker'
alias dru='docker run -it --rm -v ~/repos/dotfiles:/root/dotfiles ubuntu bash'
alias ik8s='~/dotfiles/scripts/install_k8s'
alias da='direnv allow'

# DevPod aliases
alias ds='devpod ssh'
alias du='devpod up .'

# Nix
alias nr='sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/repos/dotfiles/config/nix#Alexis-MBA'

# SSH
alias sshhs='ssh alexyz@homeserveralexyz'

