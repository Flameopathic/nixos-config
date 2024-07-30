{ pkgs, ... }: {
  # basic utilities and configuration to set up an unturned server
  environment.systemPackages = [ pkgs.steam-run pkgs.steamcmd ];
}
