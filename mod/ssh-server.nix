{ config, pkgs, inputs, lib, ... }:

with lib;

let
	cfg = config.flame.ssh-server;
in {
	options.flame.ssh-server = {
		enable = mkEnableOption "make this machine a ssh server";
		openFirewall = mkEnableOption "open firewall ports for remote ssh connection";
	};
	
	config = mkIf cfg.enable {
		services = {
		  openssh = {
				enable = true;
				# best practice is to require public-key authentication
				settings.PasswordAuthentication = false;
				settings.KbdInteractiveAuthentication = false;
			};
		};
		users.users.flame.openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC38crYgufmRowdoWdCfMZxF0uwl2xcFuNLjnN8tspUP flame"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILc5oDe4Uk3ZgEIENiQL7gZIv1FLFh37iPs9zxrrizfP flame"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEGcYKPs7832AsYLoFTiG/T9GofZCR2Ry/JhcYA6QVJ"
		];
		users.users.root.openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC38crYgufmRowdoWdCfMZxF0uwl2xcFuNLjnN8tspUP flame"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILc5oDe4Uk3ZgEIENiQL7gZIv1FLFh37iPs9zxrrizfP flame"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINEGcYKPs7832AsYLoFTiG/T9GofZCR2Ry/JhcYA6QVJ"
		];
		networking.firewall.allowedTCPPorts = if cfg.openFirewall then [
			80
			22
		] else [];
	};
}
