{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./vscode.nix
    ./vesktop.nix
    inputs.stylix.homeManagerModules.stylix
  ];

  options.flame.ui = {
    cursorSize = lib.mkOption { default = 24; };
    minimal = lib.mkEnableOption "Only install packages necessary for testing";
  };

  config = {
    home.packages =
      with pkgs;
      [
        vlc
        file-roller
        nautilus
        ncdu
      ]
      ++ lib.optionals (!config.flame.ui.minimal)
      [
        geeqie
        prismlauncher
        freetube
        orca-slicer
        freecad-wayland
        blender
        libreoffice
        hunspellDicts.en_US # for libreoffice
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
