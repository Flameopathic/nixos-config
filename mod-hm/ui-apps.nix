{ config, pkgs, inputs, ... }: {
	imports = [
		./firefox.nix
		./vscode.nix
		inputs.nix-colors.homeManagerModules.default
	];

	config = {
		colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;
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
			geeqie
			bottles
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
			size = 24;
		};
		
		gtk = {
			enable = true;
			cursorTheme = {
				name = "Bibata_Ghost";
				package = pkgs.bibata-cursors-translucent;
				size = 24;
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
	};
}
