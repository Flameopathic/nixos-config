{ ... }:
{
  system.stateVersion = "23.11"; # read docs before changing
  boot.loader.grub.dimensions = {
    x = 2736;
    y = 1824;
  };
}
