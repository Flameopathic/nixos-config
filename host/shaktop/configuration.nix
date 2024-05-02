{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "shaktop";

  flame = {
    setup.enable = true;
    mc-server.enable = true;
    sd-boot.enable = true;
    ssh-server = {
      enable = true;
      openFirewall = true;
    };
  };
  
  system.stateVersion = "23.11"; # Did you read the comment?
}

