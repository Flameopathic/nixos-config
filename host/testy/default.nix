{
  modules = [
    ../../mod/boot/sd-boot.nix
    ../../mod/ui
    ../../mod/ui/env/gnome.nix
    ../../mod/hardware/nvidia.nix
    ../../mod/ui/theme/rose-pine
    {
      system.stateVersion = "24.11"; # shouldn't be changed
    }

  ];
  home-modules = [
    ../../mod-hm/ui-apps.nix
    {
      flame.ui.minimal = true;
      home.stateVersion = "24.11"; # home manager can be updated without changing this - read documentation
    }
  ];
}
