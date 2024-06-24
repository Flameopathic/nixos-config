{ pkgs, ... }: {
	imports = [
		./firefox.nix
		./vscode.nix
	];

	config = {
		home.packages = with pkgs; [
			nerdfonts
			discord
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
				theme = "Rosé Pine Dawn";
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
				name = "rose-pine-dawn";
				package = pkgs.rose-pine-icon-theme;
			};
			theme = {
				name = "rose-pine-dawn";
				package = pkgs.rose-pine-gtk-theme;
			};
		};
	};
}
