{
  # https://codeberg.org/AndrewKvalheim/configuration/src/commit/9b0b0f90a2220c635f67123d435d239182f73406/hosts/main/system.nix#L24-L32
  systemd.services.configure-sound-leds = rec {
    wantedBy = [ "sound.target" ];
    after = wantedBy;
    serviceConfig.Type = "oneshot";
    script = ''
      echo follow-route > /sys/class/sound/ctl-led/mic/mode
      echo off > /sys/class/sound/ctl-led/speaker/mode # follow-route pending https://discourse.nixos.org/t/20480
    '';
  };

  system.stateVersion = "24.11";
}
