{ lib, ... }:
{
  config = {
    services.desktopManager.plasma6.enable = true;
    home-manager.sharedModules = lib.singleton ../../../mod-hm/kde.nix;
  };
}
