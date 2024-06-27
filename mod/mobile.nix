{ ... }:{
  imports = [
    ./battery.nix
  ];
  config = {
    security.pki.certificateFiles = [ ../resources/enterprise.pem ];
    systemd.tmpfiles.rules = [
      "z /sys/class/backlight/intel_backlight/brightness 0664 root wheel" # allows brillo to change brightness
    ];
  };
}
