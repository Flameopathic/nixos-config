{ config, pkgs, inputs, ... }: {
	networking.firewall.allowedTCPPorts = [
		80
		22
	];
}
