{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./theme.nix
  ];
  config = {
    stylix = {
      polarity = lib.mkDefault "dark";
      image = lib.mkDefault (
        pkgs.fetchurl {
          url = "https://github.com/rose-pine/wallpapers/blob/3bc7689c8ed539815fd6df2f001e7f47ebe9d3d3/rose_pine_circle.png?raw=true";
          sha256 = "fDe9LVeYbBZjapuYct114rDlrBk50rjDjo1sD+70HFM=";
        }
      );
      base16Scheme = lib.mkDefault {
        base00 = "191724";
        base01 = "1f1d2e";
        base02 = "26233a";
        base03 = "6e6a86";
        base04 = "908caa";
        base05 = "e0def4";
        base06 = "e0def4";
        base07 = "524f67";
        base08 = "eb6f92";
        base09 = "f6c177";
        base0A = "ebbcba";
        base0B = "31748f";
        base0C = "9ccfd8";
        base0D = "c4a7e7";
        base0E = "f6c177";
        base0F = "524f67";
      };
    };

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
      vesktop.vencord.theme =
        builtins.readFile (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/rose-pine/discord/refs/heads/main/rose-pine.theme.css";
            sha256 = "9VwZ9HE0scu/TX/95IYfzo92fIqlz8Xk1L1lk1Nvmok=";
          }
        )
        + ''
          :root {
              --font-primary: ${config.stylix.fonts.sansSerif.name};
              --font-display: ${config.stylix.fonts.sansSerif.name};
              --font-code: ${config.stylix.fonts.monospace.name};
          }
        '';
    };

    flame.vscode.theme = lib.mkDefault "Rosé Pine (no italics)";

    xdg.desktopEntries.theme-switch = {
      name = "Toggle theme";
      exec = "toggle-theme";
      categories = [ "Utility" ];
    };

    specialisation.light.configuration = {
      stylix = {
        image = ../resources/lwp.png;
        polarity = "light";
        base16Scheme = {
          base00 = "FAF4ED";
          base01 = "FFFAF3";
          base02 = "F2E9DE";
          base03 = "9893A5";
          base04 = "797593";
          base05 = "575279";
          base06 = "575279";
          base07 = "CECACD";
          base08 = "B4637A";
          base09 = "EA9D34";
          base0A = "D7827E";
          base0B = "286983";
          base0C = "56949F";
          base0D = "907AA9";
          base0E = "EA9D34";
          base0F = "CECACD";
        };
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
  };
}
