{ config, pkgs, inputs, ... }: {
  imports = [
		./hardware-configuration.nix
	];

	networking.hostName = "servnix";

  flame = {
    setup.enable = true;
    mc-server = {
      enable = true;
      ram = "6656M";
    };
    rpi-boot = {
      enable = true;
      overclock = true;
    };
    ssh-server.enable = true;
  };
  
	system.stateVersion = "23.11"; # read docs before changing
}
