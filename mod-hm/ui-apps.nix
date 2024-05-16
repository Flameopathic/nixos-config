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
			unstable.discord-screenaudio
			unstable.obsidian
			vlc
			libreoffice
			beeper
			unstable.godot_4
			prismlauncher
			gnome.file-roller
			xfce.thunar
		];
		programs = {
			kitty = {
				enable = true;
			};
		};

		flame.firefox.enable = true;
		
	  services = {
	    gnome-keyring.enable = true; # necessary for automatically logging back into nextcloud-client
	    nextcloud-client.enable = true;
	  };
	};
}
