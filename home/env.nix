{
  config,
  lib,
  ...
}:
{
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";

    REPOS = "$HOME/repos";
    GITUSER = "alexyz205";
    GHREPOS = "$HOME/repos/github.com/alexyz205";
    DOTFILES = "$HOME/repos/personal/dotfiles";
    XDG_CONFIG_HOME = "$HOME/.config";
    EZA_CONFIG_DIR = "$XDG_CONFIG_HOME/eza";

    TMUX_AUTO_START = "0";

    PASSWORD_STORE_DIR = "$HOME/.password-store";

    BAT_THEME = "Catppuccin Mocha";
    PAGER = "bat";
    GIT_PAGER = "bat";

    LANG = "en_US.UTF-8";
  };
}
