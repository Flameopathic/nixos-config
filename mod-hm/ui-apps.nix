{ config, pkgs, inputs, lib, ... }:

with lib;

let
	cfg = config.flame.ui-apps;
in {
	options.flame.ui-apps = {
	  enable = mkEnableOption "most used ui apps";
	};
	
	config = mkIf cfg.enable {
		home.packages = with pkgs; [
			nerdfonts
			unstable.discord-screenaudio
			unstable.obsidian
			vlc
			libreoffice
			hunspellDicts.en_US
			beeper
			unstable.godot_4
			prismlauncher
			gnome.file-roller
			# fm # really good looking file manager, gonna wait until it's a bit better on the back end
			pcmanfm
			geeqie
		];
		programs = {
			kitty = {
				enable = true;
			};
		};

		flame.firefox.enable = true;
		
		gtk = {
			enable = true;
			# cursorTheme = {
			# 	name = "quintom";
			# 	package = pkgs.quintom-cursor-theme;
			# };
			# iconTheme = {
			# 	name = "tau-hydrogen";
			# 	package = pkgs.tau-hydrogen;
			# };
			# theme = {
			# 	name = "Fluent";
			# 	package = pkgs.fluent-gtk-theme;
			# };
		};
	};
}
