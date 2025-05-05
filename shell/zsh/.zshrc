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

# ~~~~~~~~~~~~~~~ Zsh Completion Initialization ~~~~~~~~~~~~~~~~~~~~~~~~

# Initialize completion system early to ensure compdef is available
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ~~~~~~~~~~~~~~~ FZF Configuration ~~~~~~~~~~~~~~~~~~~~~~~~

# Catppuccin theme colors for FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#cdd6f4,fg+:#a6e3a1,bg:#313244,bg+:#262626
  --color=hl:#89b4fa,hl+:#5fd7ff,info:#cba6f7,marker:#a6e3a1
  --color=prompt:#94e2d5,spinner:#f5c2e7,pointer:#f5c2e7,header:#87afaf
  --color=border:#f5c2e7,preview-border:#89b4fa,preview-label:#cba6f7,label:#cdd6f4
  --color=query:#a6e3a1
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="1,2"
  --prompt="> " --marker=">" --pointer="◆" --separator="─"
  --scrollbar="│" --layout="reverse" --info="right"'

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-R - Paste the selected command from history onto the command-line
# Press CTRL-R again to toggle sorting by relevance
# Press CTRL-/ or ALT-/ to toggle line wrapping
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# ALT-C - cd into the selected directory
# Tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

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

if command -v carapace &> /dev/null; then
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
  source <(carapace _carapace)
else
  echo "carapace not found, skipping initialization."
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
alias ld='lazydocker'

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
