{ pkgs, lib, ... }: {
  imports = [
    ./firefox.nix
    ./vscode.nix
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
      prismlauncher
      gnome.file-roller
      gnome.nautilus
      bottles
      geeqie
      quodlibet
      yt-dlp
      ncdu
    ];

    programs = {
      kitty = {
        enable = true;
        theme = lib.mkDefault "Nord";
      };
      taskwarrior = {
        enable = true;
        dataLocation = "/home/flame/doc/.task";
        config = {
          calendar.details = "full";
          nag = "";
        };
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
