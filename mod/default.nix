{ pkgs, inputs, ... }:
{
  config = {
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;
    services.resolved.enable = true;

    time.timeZone = "US/Eastern";

    users.users.flame = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "input"
        "minecraft"
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
          system = pkgs.system;
          config.allowUnfree = true;
        };
      })
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
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [ "flame" ]; # should allow for remote builds
      };
      gc = {
        # garbage collection
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
