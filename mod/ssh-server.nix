{ config, lib, ... }:
let
	cfg = config.flame.ssh-server;
in {
	options.flame.ssh-server = {
		openFirewall = lib.mkEnableOption "open firewall ports for remote ssh connection";
		pubKeys = lib.mkOption {
			default = [
				"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC38crYgufmRowdoWdCfMZxF0uwl2xcFuNLjnN8tspUP flame"
				"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILc5oDe4Uk3ZgEIENiQL7gZIv1FLFh37iPs9zxrrizfP flame"
				"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEGcYKPs7832AsYLoFTiG/T9GofZCR2Ry/JhcYA6QVJ"
			];
		};
	};
	
	config = {
		services = {
		  openssh = {
				enable = true;
				# best practice is to require public-key authentication
				settings.PasswordAuthentication = false;
				settings.KbdInteractiveAuthentication = false;
			};
		};
		users.users = {
			flame.openssh.authorizedKeys.keys = cfg.pubKeys;
			users.users.root.openssh.authorizedKeys.keys = cfg.pubKeys;
		};
		networking.firewall.allowedTCPPorts = if cfg.openFirewall then [
			80
			22
		] else [];
	};
}
