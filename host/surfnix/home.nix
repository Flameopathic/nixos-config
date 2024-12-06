{ config, ... }:
{
  home.sessionVariables = {
    GDK_SCALE = 2;
  };

  systemd.user.tmpfiles.rules = [
    "L ${config.home.homeDirectory}/dld - - - - /mnt/sd/dld"
    "L ${config.home.homeDirectory}/pic - - - - /mnt/sd/pic"
    "L ${config.home.homeDirectory}/arc - - - - /mnt/sd/arc"
  ];

  home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
}
