{ ... }: {
  imports = [
		./hardware-configuration.nix
	];
  
	system.stateVersion = "23.11"; # read docs before changing
}
