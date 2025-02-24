{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./vscode.nix
    ./vesktop.nix
  ];

  options.flame.ui = {
    minimal = lib.mkEnableOption "Only install packages necessary for testing";
  };

  config = {
    home.packages =
      with pkgs;
      [
        vlc
        file-roller
        nautilus
      ]
      ++ lib.optionals (!config.flame.ui.minimal) [
        geeqie
        prismlauncher
        freetube
        bambu-studio
        freecad-wayland
        blender
        libreoffice
        hunspellDicts.en_US # for libreoffice
        qdirstat
        gimp
        upscaler
        imagemagick
      ];

    programs = {
      foot = {
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
