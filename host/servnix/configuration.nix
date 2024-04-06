{ config, pkgs, inputs, ... }: {
  imports = [
		./hardware-configuration.nix
	];

	networking.hostName = "servnix";

	system.stateVersion = "23.11"; # read docs before changing
}
