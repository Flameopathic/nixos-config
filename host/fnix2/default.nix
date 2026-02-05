{
  modules = [
    ../../mod/boot/grub
    ../../mod/hardware/nvidia.nix
    ../../mod/hardware/remote-builder.nix
    ../../mod/server/mc.nix
    ../../mod/server/ssh.nix
    ../../mod/syncthing.nix
    ../../mod/ui/theme/rose-pine
    ../../mod/ui
    ../../mod/ui/apps/gaming.nix
    ../../mod/ui/env/hyprland
    (
      { pkgs, ... }:
      {
        hardware.logitech.wireless.enable = true;

        boot.loader.grub.dimensions = {
          x = 5120;
          y = 1440;
        };

        environment.systemPackages = with pkgs; [
          solaar
        ];

        networking.interfaces.eno1.wakeOnLan.enable = true;

        system.stateVersion = "23.11"; # shouldn't be changed
      }
    )
  ];
  home-modules = [
    ../../mod-hm/ui-apps.nix
    (
      { lib, ... }:
      {
        home.sessionVariables = {
          GDK_SCALE = 2;
        };

        flame.hyprland.monitor = [
          "Unknown-1, disabled"
          "DP-2, 5120x1440@239.76Hz, 0x0, 1.25, vrr, 1"
          "HDMI-A-1, highres, auto, 2, vrr, 1"
        ];
        wayland.windowManager.hyprland.settings.exec-once =
          lib.mkForce "swaylock & swww-daemon & mako & nm-applet & pasystray & spotify";

        home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
      }
    )
  ];
}
