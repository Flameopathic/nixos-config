{ ... }:
{
  imports = [ ./gdm.nix ];
  services.xserver.desktopManager.gnome.enable = true;
}
