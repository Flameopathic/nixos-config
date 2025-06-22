{ lib, ... }:
{
  config = {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma6.enable = true;
    };
    home-manager.sharedModules = lib.singleton ../mod-hm/kde.nix;
  };
}
