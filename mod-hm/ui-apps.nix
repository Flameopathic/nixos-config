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
