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
    (
      { pkgs, ... }:
      {
        boot.kernelPackages = pkgs.linuxPackages_6_17;

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
