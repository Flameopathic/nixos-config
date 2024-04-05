{ config, pkgs, inputs, ... }: {
	services.openssh = {
		enable = true;
		# best practice is to require public-key authentication
		settings.PasswordAuthentication = false;
		settings.KbdInteractiveAuthentication = false;
	};
	users.users."flame".openssh.authorizedKeys.keys = [
		""
	];
}
