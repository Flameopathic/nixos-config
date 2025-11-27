{
  modules = [
    ../../mod/grub.nix
    ../../mod/ui.nix
    ../../mod/hyprland.nix
    ../../mod/surface.nix
    ../../mod/syncthing.nix
    ../../mod/rose-pine.nix
    (
      { ... }:
      {
        services.logind = {
          powerKey = "suspend";
          powerKeyLongPress = "poweroff";
        };

        system.stateVersion = "23.11";

        boot.loader.grub.dimensions = {
          x = 2736;
          y = 1824;
        };
      }
    )
  ];
  home-modules = [
    ../../mod-hm/ui-apps.nix

    (
      { config, ... }:
      {
        home.sessionVariables = {
          GDK_SCALE = 2;
        };

        flame.hyprland.monitor = [
          "eDP-1, preferred, 1920x0, auto"
          "DP-1, preferred, 0x0, 1"
        ];

        systemd.user.tmpfiles.rules = [
          "L ${config.home.homeDirectory}/dld - - - - /mnt/sd/dld"
          "L ${config.home.homeDirectory}/pic - - - - /mnt/sd/pic"
          "L ${config.home.homeDirectory}/arc - - - - /mnt/sd/arc"
        ];

        home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
      }
    )
  ];
}
