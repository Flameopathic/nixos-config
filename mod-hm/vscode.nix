{ config, pkgs, inputs, lib, ... }:

with lib;

let
  cfg = config.flame.vscode;
in {
  options.flame.vscode = {
    enable = mkEnableOption "enable VSCode program with special settings to work with gnome-libsecret";
  };
  
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        mvllow.rose-pine
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";
        "workbench.sideBar.location" = "right";
        "explorer.confirmDragAndDrop" = false;
        "remoteHub.commitDirectlyWarning" = "off";
        "git.enableSmartCommit" = true;
        "workbench.colorTheme" = "Rosé Pine Dawn (no italics)";
      };
    };
    xdg.desktopEntries = {
      code = {
        name = "Visual Studio Code";
        genericName = "Text Editor";
        exec = "code --password-store=\"gnome-libsecret\"";
        icon = "vscode";
        comment = "Code Editing. Redefined.";
        categories = [ "Utility" "TextEditor" "Development" "IDE" ];
        actions.new-empty-window = {
          exec = "code --new-window --password-store=\"gnome-libsecret\"";
        	icon = "vscode";
        	name = "New Empty Window";
        };
        mimeType = [ "text/plain" "inode/directory" ];
        startupNotify = true;
        type = "Application";
        settings = {
          Keywords = "vscode";
        	StartupWMClass = "Code";
        };
      };
    };
  };
}
