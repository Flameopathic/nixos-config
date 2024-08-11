{ config, pkgs, lib, inputs, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];
  config = {
    colorScheme = lib.mkDefault inputs.nix-colors.colorSchemes.rose-pine-moon;

    home.packages = with pkgs; [
      (writeShellApplication {
        # credit: Janik-Haag
        name = "toggle-theme";
        runtimeInputs = with pkgs; [ home-manager coreutils ripgrep ];
        text = ''
          "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate && hyprctl reload
        '';
      })
    ];

    home.pointerCursor = {
      gtk.enable = true;
      package = config.gtk.cursorTheme.package;
      name = config.gtk.cursorTheme.name;
      size = config.gtk.cursorTheme.size;
    };

    gtk = {
      enable = true;
      cursorTheme = {
        name = "Bibata_Ghost";
        package = pkgs.bibata-cursors-translucent;
        size = config.flame.ui.cursorSize;
      };
      iconTheme = {
        name = config.gtk.theme.name;
        package = pkgs.rose-pine-icon-theme;
      };
      theme = {
        name = lib.mkDefault "rose-pine-moon";
        package = lib.mkDefault pkgs.rose-pine-gtk-theme;
      };
    };

    xdg.desktopEntries.theme-switch = {
      name = "Toggle theme";
      exec = "toggle-theme";
      categories = [ "Utility" ];
    };

    specialisation.light.configuration = {
      colorScheme = {
        slug = "nord-light";
        name = "Nord Light";
        author = "threddast, based on fuxialexander's doom-nord-light-theme (Doom Emacs)";
        palette = {
          base00 = "e5e9f0";
          base01 = "c2d0e7";
          base02 = "b8c5db";
          base03 = "aebacf";
          base04 = "60728c";
          base05 = "2e3440";
          base06 = "3b4252";
          base07 = "29838d";
          base08 = "99324b";
          base09 = "ac4426";
          base0A = "9a7500";
          base0B = "4f894c";
          base0C = "398eac";
          base0D = "3b6ea8";
          base0E = "97365b";
          base0F = "5272af";
        };
      };

      gtk.theme = {
        name = "";
        package = pkgs.};

        flame.hyprland.wallpaper = "lwp.png";

        programs.bash.shellAliases.snrbs = "sudo nixos-rebuild switch && toggle-theme";

        home.packages = with pkgs; [
          # credit: Janik-Haag 
          (hiPrio (writeShellApplication {
            name = "toggle-theme";
            runtimeInputs = with pkgs; [ home-manager coreutils ripgrep ];
            text =
              ''
                						"$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate && hyprctl reload
                					'';
          }))
        ];
      };
    };
  }
