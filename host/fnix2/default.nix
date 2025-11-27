{
  modules = [
    ../../mod/grub.nix
    ../../mod/ui.nix
    ../../mod/hyprland.nix
    ../../mod/nvidia.nix
    ../../mod/remote-builder.nix
    ../../mod/ssh-server.nix
    ../../mod/syncthing.nix
    ../../mod/rose-pine.nix
    ../../mod/gaming.nix
    ../../mod/mc-server.nix
    (
      { pkgs, ... }:
      {
        hardware.logitech.wireless.enable = true;

        boot.loader.grub.dimensions = {
          x = 4096;
          y = 2160;
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
          "DP-1, highres, 0x0, auto"
          "HDMI-A-1, highres, auto, 2, vrr, 1"
        ];
        wayland.windowManager.hyprland.settings.exec-once =
          lib.mkForce "swaylock & swww-daemon & mako & nm-applet & pasystray & spotify";

        home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
      }
    )
  ];
}
