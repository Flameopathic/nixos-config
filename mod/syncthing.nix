{ config, inputs, pkgs, lib }:

with lib;

let
	cfg = config.flame.syncthing;
in {
	options.flame.syncthing = {
		enable = mkEnableOption "syncthing configuration";
		server = mkEnableOption "syncthing server";
	};

	config = mkIf cfg.enable {
		services.syncthing = {
			enable = true;
			openDefaultPorts = cfg.server;
			user = mkDefault "flame";
			dataDir = mkDefault "/home/flame/syncthing";
			configDir = mkDefault "/home/flame/syncthing/.config/syncthing";
			# overrideDevices = mkDefault true;
			# overrideFolders = mkDefault true;
			# settings = {
			# 	device = {
			# 		"fnix2" = 
			# 	};
			# };
		}
	}
}
