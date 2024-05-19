{ config, inputs, pkgs, lib, ... }:

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
			# configDir = mkDefault "/home/flame/doc/.config/syncthing";
			overrideDevices = mkDefault true;
			overrideFolders = mkDefault true;
			
			settings = {
				devices = {
					"fnix2" = {
						id = "ONYBVSG-TRXS6VT-CXQ737X-CD4QQ5B-PQEJIC6-23CORFG-RA3MGDZ-X6YYBQP";
					};
				};
				folders = {
					doc = {
						path = "/home/flame/doc";
						devices = [ "fnix2" ];
						id = "doc";
					};
				};
				options = {
					urAccepted = -1;
				};
			};
		};
	};
}
