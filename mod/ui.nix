{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [ pkgs.where-is-my-sddm-theme ]; # themeing not working
    services.xserver.enable = true;

    services.printing.enable = true;

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
    systemd.services.spacenavd.wantedBy = [ "graphical.target" ]; # will be upstreamed by https://github.com/NixOS/nixpkgs/pull/366768

    # makes some things log in better; compatibility feature
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;

    # stuff to make hyprland happier
    environment.sessionVariables = {
      # makes cursor visible on nvidia - not necessarily necessary for others, testing necessary
      WLR_NO_HARDWARE_CURSORS = "1";
      # hints electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
