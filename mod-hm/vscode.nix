{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  cfg = config.flame.vscode;

in
{
  imports = [ inputs.vscode-server.homeModules.default ];

  options.flame.vscode.theme = lib.mkOption {
    default = "";
    description = "string name of theme";
  };

  config = {
    home.packages = [
      pkgs.nixd # language server
      pkgs.nixfmt-rfc-style
    ];
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        arcticicestudio.nord-visual-studio-code
        # rust-lang.rust-analyzer
        ms-python.python
        eamodio.gitlens
        ms-vscode-remote.remote-ssh
        github.vscode-github-actions
        zaaack.markdown-editor
      ];
      userSettings = {
        "window.titleBarStyle" = "custom";
        "workbench.sideBar.location" = "right";
        "explorer.confirmDragAndDrop" = false;
        "remoteHub.commitDirectlyWarning" = "off";
        "git.enableSmartCommit" = true;
        "workbench.colorTheme" = cfg.theme;
        "git.confirmSync" = false;
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "nixfmt";
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "diagnostic" = {
              "suppress" = [ "sema-escaping-with" ];
            };
          };
        };
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.formatOnPaste" = true;
      };
      userTasks = {
        version = "2.0.0";
        tasks = [
          {
            label = "format all nix files";
            type = "shell";
            command = "find . -name \"*.nix\" -exec nixpkgs-fmt {} \\;";
          }
        ];
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
        categories = [
          "Utility"
          "TextEditor"
          "Development"
          "IDE"
        ];
        actions.new-empty-window = {
          exec = "code --new-window --password-store=\"gnome-libsecret\"";
          icon = "vscode";
          name = "New Empty Window";
        };
        mimeType = [
          "text/plain"
          "inode/directory"
        ];
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
