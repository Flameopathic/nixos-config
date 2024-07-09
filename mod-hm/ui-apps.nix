{ config, pkgs, inputs, lib, ... }: 

let cfg = config.flame.ui;
in {
	imports = [
		./firefox.nix
		./vscode.nix
		inputs.nix-colors.homeManagerModules.default
	];

	options.flame.ui.cursorSize = lib.mkOption {
		default = 24;
	};

	config = {
		colorScheme = lib.mkDefault inputs.nix-colors.colorSchemes.rose-pine-moon;
		home.packages = with pkgs; [
			nerdfonts
			discord-screenaudio
			obsidian
			vlc
			libreoffice
			hunspellDicts.en_US
			godot_4
			bambu-studio
			prismlauncher
			gnome.file-roller
			# fm # really good looking file manager, gonna wait until it's a bit better on the back end
			pcmanfm
			bottles
			(writeShellApplication { # credit: Janik-Haag
        name = "toggle-theme";
        runtimeInputs = with pkgs; [ home-manager coreutils ripgrep ];
        text =
          ''
            "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate && hyprctl reload
          '';
      })
			geeqie
		];
		programs = {
			kitty = {
				enable = true;
				theme = config.colorScheme.name;
			};
		};

		home.pointerCursor = {
			gtk.enable = true;
			package = pkgs.bibata-cursors-translucent;
			name = "Bibata_Ghost";
			size = cfg.cursorSize;
		};
		
		gtk = {
			enable = true;
			cursorTheme = {
				name = "Bibata_Ghost";
				package = pkgs.bibata-cursors-translucent;
				size = cfg.cursorSize;
			};
			iconTheme = {
				name = if config.colorScheme.name == "Rosé Pine Dawn" then "rose-pine-dawn" else if config.colorScheme.name == "Rosé Pine Moon" then "rose-pine-moon" else "";
				package = pkgs.rose-pine-icon-theme;
			};
			theme = {
				name = if config.colorScheme.name == "Rosé Pine Dawn" then "rose-pine-dawn" else if config.colorScheme.name == "Rosé Pine Moon" then "rose-pine-moon" else "";
				package = pkgs.rose-pine-gtk-theme;
			};
		};

		xdg.desktopEntries = {
      shutdown = {
        name = "Shutdown now";
        exec = "shutdown now";
        comment = "Shutdown computer immediately";
        categories = [ "Utility" ];
      };
      reboot = {
        name = "Reboot";
        exec = "reboot";
        categories = [ "Utility" ];
      };
      theme-switch = lib.mkDefault {
        name = "Toggle theme";
        exec = "toggle-theme";
        categories = [ "Utility" ];
      };
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
			flame.hyprland.wallpaper = "lwp.png";
		};
	};
}
