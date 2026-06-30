{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.winboat ];
  virtualisation.docker.enable = true;
  users.users.flame.extraGroups = [ "docker" ];
}
