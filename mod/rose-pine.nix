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

          programs.vesktop.vencord.themes.stylix = builtins.readFile "${inputs.hide-elements-vesktop-theme}";

          flame.vscode.theme = lib.mkDefault "Rosé Pine (no italics)";

          xdg.desktopEntries.theme-switch = {
            name = "Toggle theme";
            exec = "toggle-theme";
            categories = [ "Utility" ];
          };


          specialisation.light.configuration = {
            stylix = {
              image = ../resources/rose-pine/gradient-nix.png;
              polarity = "light";
              base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";
            };

            gtk.theme.name = lib.mkOverride 10 "rose-pine-dawn";

            flame.vscode.theme = "Rosé Pine Dawn (no italics)";

            programs.bash.shellAliases.snrbs = "sudo nixos-rebuild switch && toggle-theme";

            home.packages = with pkgs; [
              # credit: Janik-Haag
              (hiPrio (writeShellApplication {
                name = "toggle-theme";
                runtimeInputs = with pkgs; [
                  home-manager
                  coreutils
                  ripgrep
                ];
                text = ''
                  "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate && hyprctl reload
                '';
              }))
            ];
          };
        }
      )
    ];
  };
}
