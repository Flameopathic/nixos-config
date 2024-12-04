{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./vscode.nix
    ./vesktop.nix
    inputs.stylix.homeManagerModules.stylix
  ];

  options.flame.ui.cursorSize = lib.mkOption { default = 24; };

  config = {
    home.packages = with pkgs; [
      nerdfonts
      obsidian
      vlc
      libreoffice
      hunspellDicts.en_US
      godot_4
      prismlauncher
      file-roller
      nautilus
      bottles
      geeqie
      quodlibet
      yt-dlp
      ncdu
      freetube
    ];

    stylix = {
      enable = true;
      polarity = lib.mkDefault "dark";
      image = lib.mkDefault ../resources/leafy-moon.png;
      base16Scheme = lib.mkDefault {
        base00 = "#232136";
        base01 = "#2a273f";
        base02 = "#393552";
        base03 = "#6e6a86";
        base04 = "#908caa";
        base05 = "#e0def4";
        base06 = "#e0def4";
        base07 = "#56526e";
        base08 = "#eb6f92";
        base09 = "#f6c177";
        base0A = "#ea9a97";
        base0B = "#3e8fb0";
        base0C = "#9ccfd8";
        base0D = "#c4a7e7";
        base0E = "#f6c177";
        base0F = "#56526e";
      };
      cursor = {
        package = pkgs.bibata-cursors-translucent;
        name = "Bibata_Ghost";
        size = 24;
      };
      fonts = {
        # emoji.name = "iMWriting Nerd Font";
        monospace = {
          name = "Maple Mono NF";
          package = pkgs.maple-mono-NF;
        };
        # sansSerif = {
        #   name = "NotoSans NF";
        #   package = pkgs.nerdfonts;
        # };
        # serif = {
        #   name = "NotoSerif NF";
        #   package = pkgs.nerdfonts;
        # };
        sizes = {
          # applications = ;
          # desktop = ;
          # popups = ;
          terminal = 11;
        };
      };
      targets = {
        vscode.enable = false;
        gtk.enable = false;
        waybar.enable = false;
      };
    };

    programs = {
      kitty = {
        enable = true;
      };
    };

    xdg.desktopEntries = {
      shutdown = {
        name = "Shutdown now";
        exec = "shutdown now";
        comment = "Shutdown computer immediately";
        categories = [ "Utility" ];
      };
      reboot = {
        name = "Reboot";
        exec = "reboot";
        categories = [ "Utility" ];
      };
    };
  };
}
