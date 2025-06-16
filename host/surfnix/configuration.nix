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
