{ inputs, ... }:
{
  imports = [
    inputs.jovian.nixosModules.jovian
  ];
  config = {
    services.desktopManager.plasma6.enable = true;
    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        user = "flame";
        desktopSession = "plasma";
      };
      devices.steamdeck = {
        enable = true;
      };
    };
  };
}
