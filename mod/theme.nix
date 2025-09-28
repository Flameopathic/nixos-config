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
              package = mkDefault pkgs.colloid-icon-theme;
              dark = mkDefault "Colloid";
              light = mkDefault "Colloid";
            };
            targets = {
              waybar.enable = mkDefault false;
              hyprpaper.enable = mkForce false;
              firefox.profileNames = [ "default" ];
            };
          };

          programs.zsh.shellAliases.snrbs = "sudo nixos-rebuild switch && toggle-theme";

          home.packages = with pkgs; [
            (writeShellApplication {
              # credit: Janik-Haag
              name = "toggle-theme";
              runtimeInputs = with pkgs; [
                home-manager
                coreutils
                ripgrep
              ];
              text = ''
                "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate && hyprctl reload
              '';
            })
          ];
        }
      )
    ];
  };
}
