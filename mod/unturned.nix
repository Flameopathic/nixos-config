{ pkgs, ... }: { # basic utilities and configuration to set up an unturned server
  environment.systemPackages = [ pkgs.steam-run pkgs.steamcmd ];
  networking.firewall.allowedUDPPorts = [ 27015 27016 ];
  networking.firewall.allowedTCPPorts = [ 27015 27016 ];
}