{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "shaktop";

  environment.systemPackages = [ pkgs.python3 ];

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

