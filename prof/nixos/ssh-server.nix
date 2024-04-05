{ config, pkgs, inputs, ... }: {
	services.openssh = {
		enable = true;
		# best practice is to require public-key authentication
		settings.PasswordAuthentication = false;
		settings.KbdInteractiveAuthentication = false;
	};
	users.users."flame".openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC38crYgufmRowdoWdCfMZxF0uwl2xcFuNLjnN8tspUP flame"
	];
  networking.firewall.allowedTCPPorts = [
		22
		80
	];
}
