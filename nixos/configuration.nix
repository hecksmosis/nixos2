{ inputs, ...}: {
  imports = [
    ./hardware-configuration.nix # Let it autogenerate for every system
    ./packages.nix
    ./modules/bundle.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.
  time.timeZone = "Europe/Madrid"; # Set your time zone.

  i18n = {
    defaultLocale = "en_US.UTF-8"; # Select internationalisation properties. 
    extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
    };
  };

  console.keyMap = "es";

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enabling flakes
  system.stateVersion = "24.05"; 
}
