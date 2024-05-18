{ config, pkgs, inputs, lib, ... }:

with lib;

let
  cfg = config.flame.user;
in {
  options.flame.user = {
    enable = mkEnableOption "default flame user";
  };

  config = mkIf cfg.enable {
    home.username = "flame";
    home.homeDirectory = "/home/flame";

    home.packages = with pkgs; [
      neofetch
      nerdfonts
      sbctl
      nix-tree
    ];

    programs = {
      git = {
        enable = true;
        userName = "Flameopathic";
        userEmail = "flameopathic@gmail.com";
        extraConfig = {
          init.defaultBranch = "main"; # makes `git init` simpler
          safe.directory = "/etc/nixos"; # make sure to chown .git to an admin
        };
      };
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          snrbs = "sudo nixos-rebuild switch";
          conf = "cd /etc/nixos";
          ".." = "cd ..";
        };
      };
      helix = {
        enable = true;
        defaultEditor = true;
      };
    };

    # TODO: move to proper place
    xdg.desktopEntries = {
      shutdown = {
        name = "Shutdown";
        exec = "shutdown now";
        comment = "Shutdown computer immediately";
        categories = [ "Utility" ];
      };
      reboot = {
        name = "Reboot";
        exec = "reboot";
        comment = "Reboot computer.";
        categories = [ "Utility" ];
      };
    };

    home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
    programs.home-manager.enable = true;
  };
}
