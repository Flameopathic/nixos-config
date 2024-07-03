{ config, pkgs, inputs, lib, ... }: {
	imports = [
		./firefox.nix
		./vscode.nix
		inputs.nix-colors.homeManagerModules.default
		./stylix.nix
	];

	config = {
		home.packages = with pkgs; [
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
		];
		programs = {
			kitty = {
				enable = true;
			};
		};

		gtk = {
			enable = true;
			iconTheme = {
				name = lib.mkDefault "rose-pine-moon";
				package = pkgs.rose-pine-icon-theme;
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

			gtk.iconTheme.name = "rose-pine-dawn";
			stylix = {
				image = ../resources/lwp.png;
				base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-dawn.yaml";
			};
		};
	};
}
