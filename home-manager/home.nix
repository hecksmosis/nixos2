{

  imports = [
    ./zsh.nix
    ./modules/bundle.nix
  ];

  home = {
    username = "hecksmosis";
    homeDirectory = "/home/hecksmosis";
    stateVersion = "23.11";
  };
}
