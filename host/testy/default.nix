{
  modules = [
    ../../mod/sd-boot.nix
    ../../mod/ui.nix
    ../../mod/gnome.nix
    ../../mod/nvidia.nix
    ../../mod/rose-pine.nix
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
