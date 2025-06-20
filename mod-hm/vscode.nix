{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}:
{
  imports = [ inputs.vscode-server.homeModules.default ];

  config = {
    home.packages = [
      pkgs.nil # language server
      pkgs.unstable.nixfmt-rfc-style
    ];
    programs.vscode = {
      enable = true;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions =
          with pkgs.vscode-extensions;
          lib.mkForce [
            jnoortheen.nix-ide
            mvllow.rose-pine
            eamodio.gitlens
            davidanson.vscode-markdownlint
          ];
        userSettings = {
          "telemetry.telemetryLevel" = "off";
          "window.titleBarStyle" = "custom";
          "workbench.sideBar.location" = "left";
          "explorer.confirmDragAndDrop" = false;
          "remoteHub.commitDirectlyWarning" = "off";
          "git.enableSmartCommit" = true;
          "git.confirmSync" = false;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "nix.serverSettings" = {
            "nil" = {
              "diagnostic" = {
                "suppress" = [ "sema-escaping-with" ];
              };
              "formatting" = {
                "command" = [
                  "nixfmt"
                  "-w=80"
                ];
              };
              "options" = {
                "nixos" = {
                  "expr" =
                    "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.${osConfig.networking.hostName}.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake \"/etc/nixos\").homeConfigurations.flame.options";
                };
              };
              "nix"."flake"."autoArchive" = true;
            };
          };
          "workbench.startupEditor" = "none";
          "chat.commandCenter.enabled" = false;
          "diffEditor.renderSideBySide" = true;
          "explorer.confirmDelete" = false;
          "update.showReleaseNotes" = false;
          "git.autofetch" = true;
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
