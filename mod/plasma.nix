{ ... }:
{
  config.services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    xserver.desktopManager.plasma5.enable = true;
  };
}
