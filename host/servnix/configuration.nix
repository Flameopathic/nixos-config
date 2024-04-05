{ config, pkgs, inputs, ... }: {
  imports = [
		./hardware-configuration.nix
	];

	networking.hostName = "servnix";

	users.users.flame = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
	};

	system.stateVersion = "23.11"; # read docs before changing
}
