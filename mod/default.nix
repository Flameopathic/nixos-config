{ pkgs, inputs, ... }: {
  config = {
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;
    services.resolved.enable = true;

    time.timeZone = "US/Eastern";

    users.users.flame = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" ]; # Enable ‘sudo’ for the user.
      initialPassword = "snepis";
    };

    nixpkgs.overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = pkgs.system;
          config.allowUnfree = true;
        };
      })
    ];

    environment.systemPackages = with pkgs; [
      wget
      git
    ];

    services.gnome.gnome-keyring.enable = true; # makes some things log in better; compatibility feature

    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "flame" ]; # should allow for remote builds
      };
      gc = {
        # garbage collection
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
    };
  };
}
