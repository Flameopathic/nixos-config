{
  config = {
    services.xserver.enable = true;

    # printing
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };

    # audio
    security.rtkit.enable = true; # not entirely sure what this does, but the wiki said it was good
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    hardware = {
      bluetooth.enable = true;
      spacenavd.enable = true;
    };

    # makes some things log in better; compatibility feature
    services.gnome.gnome-keyring.enable = true;

    # stuff to make hyprland happier
    environment.sessionVariables = {
      # makes cursor visible on nvidia - not necessarily necessary for others, testing necessary
      WLR_NO_HARDWARE_CURSORS = "1";
      # hints electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
