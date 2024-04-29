{ config, pkgs, inputs, ... }: {
  programs.vscode = {
    enable = true;
    userSettings = {
      "window.titleBarStyle" = "custom";
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
}
