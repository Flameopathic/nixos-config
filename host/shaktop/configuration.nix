{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.python3 pkgs.steam-run ];
  


  system.stateVersion = "23.11"; # Did you read the comment?
}

