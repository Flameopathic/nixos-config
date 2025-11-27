{ inputs }:
{
  modules = [
    inputs.nixos-hardware.nixosModules.lenovo-yoga-7-14ILL10
    ../../mod/grub.nix
    ../../mod/mobile.nix
    ../../mod/ui.nix
    ../../mod/hyprland.nix
    ../../mod/remote-builder.nix
    ../../mod/syncthing.nix
    ../../mod/rose-pine.nix
    ../../mod/gaming.nix
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
  ];
  home-modules = [
    ../../mod-hm/ui-apps.nix
    {
      flame.hyprland.monitor = [
        "eDP-1, preferred, 1920x0, 1.25"
        "DP-1, preferred, 0x0, 1"
      ];
      home.stateVersion = "24.11";
    }
  ];
}
