{ ... }:
{
  imports = [ ../dm/gdm.nix ];
  services.desktopManager.gnome.enable = true;
}
