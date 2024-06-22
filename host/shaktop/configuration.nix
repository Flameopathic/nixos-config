{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [ pkgs.python3 ];
  
  system.stateVersion = "23.11"; # Did you read the comment?
}

