{ inputs }:
{
  modules = [
    inputs.nixos-hardware.nixosModules.lenovo-yoga-7-14ILL10
    ../../mod/boot/grub
    ../../mod/hardware/remote-builder.nix
    ../../mod/hardware/mobile
    ../../mod/syncthing.nix
    ../../mod/ui/theme/rose-pine
    ../../mod/ui
    ../../mod/ui/apps/gaming.nix
    ../../mod/ui/env/kde.nix
    (
      { pkgs, ... }:
      {
        system.stateVersion = "24.11";

        services.udev.extraRules = ''
          SUBSYSTEM=="usb", ATTR{idVendor}=="1a86", ATTR{idProduct}=="7584", MODE="0666"
        '';

        boot.kernelModules = [
          "lp"
          "parport"
          "parport_pc"
        ];

        systemd.services.fnlock-off = {
          wantedBy = [ "multi-user.target" ];
          description = "Deactivate fn lock LED";
          script = ''
            echo "0" > "/sys/class/leds/platform::fnlock/brightness"
          '';
        };
      }
    )
  ];
  home-modules = [
    ../../mod-hm/ui-apps.nix
    {
      # flame.hyprland.monitor = [
      #   "eDP-1, preferred, 192x0, 1.25"
      #   "DP-1, preferred, 0x960, 1"
      # ];
      home.stateVersion = "24.11";
    }
  ];
}
