{
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./outer-wilds-grub.nix
  ];

  config = {
    stylix = {
      enable = mkDefault true;
      polarity = mkDefault "dark";
      cursor = {
        package = mkDefault pkgs.bibata-cursors;
        name = mkDefault "Bibata-Original-Classic";
        size = mkDefault 20;
      };
      fonts = {
        monospace = {
          name = mkDefault "GeistMono NF";
          package = mkDefault pkgs.nerd-fonts.geist-mono;
        };
        sansSerif = {
          name = mkDefault "Geist";
          package = mkDefault pkgs.geist-font;
        };
        sizes = {
          terminal = mkDefault 11;
        };
      };
    };

    home-manager.sharedModules = [
      (
        { config, ... }:
        {
          stylix = {
            iconTheme = {
              package = pkgs.colloid-icon-theme;
              dark = mkForce "Colloid";
              light = mkForce "Colloid";
            };
            targets = {
              waybar.enable = mkDefault false;
              hyprpaper.enable = mkForce false;
              firefox.profileNames = [ "default" ];
            };
          };

          programs.zsh.shellAliases.snrbs = "sudo nixos-rebuild switch";

          home.packages = with pkgs; [
            (writeShellApplication {
              # credit: Janik-Haag
              name = "toggle-theme";
              runtimeInputs = with pkgs; [
                lxqt.lxqt-sudo
              ];
              text = ''
                lxsudo /nix/var/nix/profiles/system/specialisation/light/bin/switch-to-configuration switch
              '';
            })
          ];
        }
      )
    ];
  };
}
