{ config, pkgs, inputs, ... }: {
	services = {
	  avahi = {
			enable = true;
			nssmdns = true;
		};
	  openssh = {
			enable = true;
			# best practice is to require public-key authentication
			settings.PasswordAuthentication = false;
			settings.KbdInteractiveAuthentication = false;
		};
	};
	users.users.root.openssh.authorizedKeys.keys = [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC38crYgufmRowdoWdCfMZxF0uwl2xcFuNLjnN8tspUP flame"
	];
}
