{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  config = {
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;
    services.resolved.enable = true;

    time.timeZone = lib.mkDefault "US/Central";

    users.users.flame = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "input"
        "minecraft"
        "wireshark"
      ]; # Enable ‘sudo’ for the user.
      initialHashedPassword = "$y$j9T$Vwe6OnkGTBX4BF2ka.Ihw0$L4AU5TxtOQSLAnyHwoT0wKB7S5FQTGlK9XCwFemZjU2";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };
    users.defaultUserShell = pkgs.zsh;
    environment.pathsToLink = [ "/share/zsh" ];

    nixpkgs.overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = pkgs.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
      })
      inputs.dolphin-overlay.overlays.default
    ];

    environment.systemPackages = with pkgs; [
      wget
      git
    ];

    # configuration that only applies within VMs made through `nixos-rebuild build-vm`
    virtualisation.vmVariant.virtualisation = {
      memorySize = 4096;
      cores = 4;
    };

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [ "flame" ]; # should allow for remote builds
      };

      # obsolete because of nh
      # settings.auto-optimise-store = true;
      # gc = {
      #   # garbage collection
      #   automatic = true;
      #   dates = "monthly";
      #   options = "--delete-older-than 30d";
      # };
    };
  };
}
