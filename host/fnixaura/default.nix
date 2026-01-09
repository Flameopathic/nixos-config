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
    ../../mod/ui/env/hyprland.nix
    (
      { pkgs, ... }:
      {
        system.stateVersion = "24.11";
      }
    )
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
