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
      ]
      ++ lib.optionals (!config.flame.ui.minimal) [
        orca-slicer
        libreoffice
        hunspellDicts.en_US # for libreoffice
        qdirstat
        krita
        ffmpeg
        imagemagick
        yt-dlp
        audacity
        obsidian
        spotify
        chromium
      ];

    programs = {
      foot.enable = true;
      # yazi = {
      #   enable = true;
      #   shellWrapperName = "y";
      # };
      # spicetify = {
      #   enable = true;
      #   spotifyPackage = pkgs.unstable.spotify;
      # };
    };

    xdg = {
      desktopEntries = {
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
      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/plain" = "zed.desktop";

          # browser
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
          "application/pdf" = "firefox.desktop";
        };
      };
    };
  };
}
