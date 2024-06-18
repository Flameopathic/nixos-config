{ ... }: {
  imports = [
		./hardware-configuration.nix
	];

	networking.hostName = "servnix";

  flame = {
    setup.enable = true;
    # mc-server = {
    #   enable = true;
    #   ram = "6656M";
    # };
    rpi-boot = {
      enable = true;
      overclock = false;
    };
    ssh-server.enable = true;
    syncthing = {
      enable = true;
      server = true;
    };
  };
  
	system.stateVersion = "23.11"; # read docs before changing
}
