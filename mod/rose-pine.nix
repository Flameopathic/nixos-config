{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./theme.nix
  ];
  config = {
    stylix = {
      image = lib.mkDefault ../resources/rose-pine/outer-wilds/planetary-chart.png;
      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    };

    home-manager.sharedModules = [
      (
        { config, ... }:
        {
          gtk = {
            iconTheme = {
              name = config.gtk.theme.name;
              package = pkgs.rose-pine-icon-theme;
            };
            theme = {
              name = lib.mkForce "rose-pine";
              package = lib.mkForce pkgs.rose-pine-gtk-theme;
            };
          };

          programs = {
            vesktop.vencord.themes.stylix = builtins.readFile "${inputs.hide-elements-vesktop-theme
            }";
            vscode.profiles.default.userSettings."workbench.colorTheme" =
              lib.mkOverride 99 "Rosé Pine (no italics)";
            zed-editor = {
              userSettings.theme = lib.mkOverride 99 "Rosé Pine";
              extensions = [ "rose-pine-theme" ];
            };
          };

          xdg.desktopEntries.theme-switch = {
            name = "Toggle theme";
            exec = "toggle-theme";
            categories = [ "Utility" ];
          };

        }
      )
    ];

    specialisation.light.configuration = {
      stylix = {
        image = ../resources/rose-pine/gradient-nix.png;
        polarity = "light";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";
      };

      home-manager.sharedModules = [
        {
          gtk.theme.name = lib.mkOverride 10 "rose-pine-dawn";

          programs = {
            vscode.profiles.default.userSettings."workbench.colorTheme" =
              lib.mkOverride 10 "Rosé Pine Dawn (no italics)";
            zed-editor.userSettings.theme = lib.mkForce "Rosé Pine Dawn";

            bash.shellAliases.snrbs = "sudo nixos-rebuild switch && toggle-theme";
          };

          home.packages = with pkgs; [
            # credit: Janik-Haag
            (lib.hiPrio (writeShellApplication {
              name = "toggle-theme";
              runtimeInputs = with pkgs; [
                lxqt.lxqt-sudo
              ];
              text = ''
                lxsudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
              '';
            }))
            (lib.hiPrio (
              pkgs.writeShellApplication {
                name = "nos";
                runtimeInputs = with pkgs; [
                  nh
                ];
                text = ''
                  nh os switch --specialisation light
                '';
              }
            ))
          ];
        }
      ];
    };
  };
}
