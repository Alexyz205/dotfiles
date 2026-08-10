{
  pkgs,
  home-manager,
}:
pkgs.mkShell {
  packages = [
    pkgs.just
    pkgs.nix
    home-manager.packages.${pkgs.system}.default
  ];

  shellHook = ''
    echo "dotfiles dev shell: use 'just' to manage tasks, 'home-manager switch --flake .' to deploy"
  '';
}
