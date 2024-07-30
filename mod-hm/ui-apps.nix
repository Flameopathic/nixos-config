{ config, pkgs, lib, ... }: {
  imports = [
    ./firefox.nix
    ./vscode.nix
    ./themes.nix
    ./vesktop.nix
  ];

  options.flame.ui.cursorSize = lib.mkOption {
    default = 24;
  };

  config = {
    home.packages = with pkgs; [
      nerdfonts
      obsidian
      vlc
      libreoffice
      hunspellDicts.en_US
      godot_4
      bambu-studio
      prismlauncher
      gnome.file-roller
      # fm # really good looking file manager, gonna wait until it's a bit better on the back end
      pcmanfm
      bottles
      geeqie
    ];

    programs = {
      kitty = {
        enable = true;
        theme = config.colorScheme.name;
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
