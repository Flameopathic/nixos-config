{ config, pkgs, lib, inputs, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];
  config = {
    colorScheme = lib.mkDefault inputs.nix-colors.colorSchemes.rose-pine-moon;

    home.packages = with pkgs; [
      (writeShellApplication { # credit: Janik-Haag
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
				package = pkgs.rose-pine-gtk-theme;
			};
		};

    xdg.desktopEntries.theme-switch = {
      name = "Toggle theme";
      exec = "toggle-theme";
      categories = [ "Utility" ];
    };

    specialisation.light.configuration = {
			colorScheme = inputs.nix-colors.colorSchemes.rose-pine-dawn;

			programs.bash.shellAliases.snrbs = "sudo nixos-rebuild switch && toggle-theme";

			home.packages = with pkgs; [ # credit: Janik-Haag 
				(hiPrio (writeShellApplication {
				name = "toggle-theme";
				runtimeInputs = with pkgs; [ home-manager coreutils ripgrep ];
				text =
					''
						"$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate && hyprctl reload
					'';
				}))
			];

      gtk.theme.name = "rose-pine-dawn";

			flame.hyprland.wallpaper = "lwp.png";
		};
  };
}