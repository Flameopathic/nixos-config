{ config, pkgs, lib, ... }: 

with lib;

let
  cfg = config.flame.ui;
in {
  options.flame.ui = {
    enable = mkEnableOption "basic ui setup";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.where-is-my-sddm-theme ];
    services = {
      xserver.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "where_is_my_sddm_theme";
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

    systemd.tmpfiles.rules = [
      "z /sys/class/backlight/intel_backlight/brightness 0664 root wheel"
    ];
  
    # stuff to make hyprland happier
    environment.sessionVariables = {
      # makes cursor visible on nvidia - not necessarily necessary for others, testing necessary
      WLR_NO_HARDWARE_CURSORS = "1";
      # hints electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  };
}
