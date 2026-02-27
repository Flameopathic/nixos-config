{
  imports = [
    # ./battery.nix
  ];
  config = {
    systemd = {
      tmpfiles.rules = [
        "z /sys/class/backlight/intel_backlight/brightness 0664 root wheel" # allows brillo to change brightness
      ];
      sleep.extraConfig = ''
        HibernateDelaySec=15m
      '';
    };
  };
}
