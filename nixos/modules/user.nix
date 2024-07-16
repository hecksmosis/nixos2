{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.hecksmosis = {
      isNormalUser = true;
      description = "Pablo García Ruiz";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
      packages = with pkgs; [];
    };
  };
}
