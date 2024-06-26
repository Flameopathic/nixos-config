{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.vscode-server.homeModules.default
  ];

  config = {
    home.packages = [ pkgs.unstable.nixd ]; # lsp
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        mvllow.rose-pine
        rust-lang.rust-analyzer
        ms-python.python
        eamodio.gitlens
        ms-vscode-remote.remote-ssh
        github.vscode-github-actions
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";
        "workbench.sideBar.location" = "right";
        "explorer.confirmDragAndDrop" = false;
        "remoteHub.commitDirectlyWarning" = "off";
        "git.enableSmartCommit" = true;
        "workbench.colorTheme" = config.colorScheme.name + " (no italics)";
        "git.confirmSync" = false;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "diagnostic" = {
              "suppress" = [
                "sema-escaping-with"
              ];
            };
          };
        };
      };
    };

    services.vscode-server.enable = true;

    xdg.desktopEntries = {
      code = {
        name = "Visual Studio Code";
        genericName = "Text Editor";
        exec = "code --password-store=\"gnome-libsecret\" --disable-gpu";
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
