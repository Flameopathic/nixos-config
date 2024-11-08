{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [ pkgs.where-is-my-sddm-theme ]; # themeing not working
    services = {
      xserver.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "where_is_my_sddm_theme";
        };
        autoLogin = {
          enable = true;
          user = "flame";
        };
      };
    };

    services.printing.enable = true;

    security.rtkit.enable = true; # not entirely sure what this does, but the wiki said it was good
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    hardware.bluetooth.enable = true;

    # stuff to make hyprland happier
    environment.sessionVariables = {
      # makes cursor visible on nvidia - not necessarily necessary for others, testing necessary
      WLR_NO_HARDWARE_CURSORS = "1";
      # hints electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
