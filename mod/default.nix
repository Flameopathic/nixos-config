{ config, pkgs, lib, inputs, ... }:

with lib; # TODO: consider removing enable option for this module and just moving any extraneous configuration to other modules

let
  cfg = config.flame.setup;
in {
  options.flame.setup = {
    enable = mkEnableOption "basic setup, useful on effectively every machine";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;
    services.resolved.enable = true;

    time.timeZone = "US/Eastern";

    users.users.flame = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };
    flame.home-manager.enable = true;

    nixpkgs.overlays = [
      (final: prev: {
        stable = import inputs.nixpkgs-stable {
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
      gc = { # garbage collection
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
    };
  };
}
