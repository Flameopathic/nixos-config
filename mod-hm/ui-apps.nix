{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    ./firefox.nix
    ./vscode.nix
    ./vesktop.nix
    ./trilium.nix
    ./zed.nix
  ];

  options.flame.ui = {
    minimal = lib.mkEnableOption "Only install packages necessary for testing";
  };

  config = {
    home.packages =
      with pkgs;
      [
        vlc
        peazip
        kdePackages.dolphin
      ]
      ++ lib.optionals (!config.flame.ui.minimal) [
        eog
        freetube
        orca-slicer
        freecad-wayland
        blender
        libreoffice
        hunspellDicts.en_US # for libreoffice
        qdirstat
        krita
        imagemagick
        yt-dlp
        eartag
        btop
        inkscape
        audacity
        flowblade
        shotcut
        chromium
        discord
        rustup
        gcc
      ];

    programs = {
      foot.enable = true;
      yazi.enable = true;
      spicetify = {
        enable = true;
        spotifyPackage = pkgs.unstable.spotify;
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
