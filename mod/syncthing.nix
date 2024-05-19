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
			overrideDevices = mkDefault true;
			overrideFolders = mkDefault true;
			settings = {
				devices = {
					"fnix2" = {
						id = "ONYBVSG-TRXS6VT-CXQ737X-CD4QQ5B-PQEJIC6-23CORFG-RA3MGDZ-X6YYBQP";
					};
					"surfnix" = {
						id = "NJRGKSE-QTLVGI6-KUIMKVT-53GP7IN-6XUTFMZ-KKG76DZ-45Q6K2Q-P6AAIAB";
					};
					"servnix" = {
						id = "DLLU755-KDYY2I7-5MSLDZC-4A5Q7IA-VJ5MCKH-F6J3XWN-GOYI2W3-OOONBQP";
					};
				};
				folders = {
					doc = {
						path = "/home/flame/doc";
						devices = [ "fnix2" "surfnix" "servnix" ];
						id = "doc";
						versioning = {
							type = "trashcan";
							params.cleanoutDays = "1000";
						};
					};
				};
				options = {
					urAccepted = -1;
				};
			};
		};
	};
}
