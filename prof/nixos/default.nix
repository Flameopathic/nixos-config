{ config, pkgs, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  time.timeZone = "US/Eastern";

  users.users.flame = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  services.gnome.gnome-keyring.enable = true; # makes nextcloud happy i suppose

  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  system.autoUpgrade = {
    enable = true;
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = { # garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
