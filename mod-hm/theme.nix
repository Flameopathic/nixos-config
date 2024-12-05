{
  lib,
  pkgs,
  config,
  ...
}:
{
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
          name = "Maple Mono NF";
          package = pkgs.maple-mono-NF;
        };
        sansSerif = config.stylix.fonts.monospace;
        serif = config.stylix.fonts.monospace;
        sizes = {
          # applications = 13;
          # desktop = ;
          # popups = ;
          terminal = 11;
        };
      };
      targets = {
        waybar.enable = false;
        hyprpaper.enable = lib.mkForce false;
      };
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
  };
}
