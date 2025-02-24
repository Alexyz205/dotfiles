# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# Directories
export REPOS="$HOME/repos"
export GITUSER="alexyz205"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export XDG_CONFIG_HOME="$HOME/.config"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

PATH="${PATH:+${PATH}:}"$SCRIPTS":"$HOME"/.local/bin"

export PATH

# ~~~~~~~~~~~~~~~ Load plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
else
  echo "Starship not found, skipping initialization."
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
  alias cd='z'
else
  echo "zoxide not found, skipping initialization."
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
else
  echo "direnv not found, skipping initialization."
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if command -v fzf &> /dev/null; then
  source <(fzf --bash)
else
  echo "fzf not found, skipping fzf initialization."
fi

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~
HISTFILE=~/.bash_history
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoreboth
HISTIGNORE="&:ls:cd:cd -:pwd:exit:date:* --help"

# completion using arrow keys (based on history)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~
alias v=nvim
alias c="clear"

# Repos
alias dot='cd $DOTFILES'
alias repos='cd $REPOS'

# ls
alias ls='eza --color=auto'
alias la='eza -la'
alias ll='eza -l --git -T --hyperlink --color=auto'

alias find='fd'
alias f='fzf'

alias t='tmux'
alias r='ranger'
alias p='python'
alias k='kubectl'
alias e='exit'

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
alias h='history'
alias reload='source ~/.bashrc'
alias ik8s='~/dotfiles/scripts/install_k8s'
