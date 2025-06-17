{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.python3
    pkgs.steam-run
    pkgs.tmux
  ];

  services.minecraft-servers.servers.eyecleft.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
