{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./outerwilds.nix
  ];

  config = {
    stylix = {
      enable = true;
      cursor = {
        package = pkgs.bibata-cursors-translucent;
        name = "Bibata_Ghost";
        size = 24;
      };
      fonts = {
        monospace = {
          name = "GeistMono NF";
          package = pkgs.nerd-fonts.geist-mono;
        };
        sansSerif = {
          name = "Geist";
          package = pkgs.geist-font;
        };
        sizes = {
          # applications = 13;
          # desktop = ;
          # popups = ;
          terminal = 11;
        };
      };
      targets.grub.enable = false;
    };

    home-manager.sharedModules = [
      {
        stylix.targets = {
          waybar.enable = false;
          hyprpaper.enable = lib.mkForce false;
        };
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
    ];
  };
}
