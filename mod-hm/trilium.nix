{ pkgs, ... }:
{
  home.packages = [
    pkgs.unstable.trilium-desktop
  ];

  xdg.desktopEntries = {
    Trilium = {
      name = "Trilium Notes";

      # sets specific trilium data directory
      exec = "env TRILIUM_DATA_DIR=/home/flame/doc/trilium-data trilium";
      icon = "trilium";
      comment = "Hierarchical note taking application with focus on building large personal knowledge bases";
      categories = [
        "Office"
      ];
      type = "Application";
      settings = {
        StartupWMClass = "Trilium Notes";
      };
    };
  };

}
