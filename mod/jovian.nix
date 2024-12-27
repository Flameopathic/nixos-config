{ inputs, ... }:
{
  imports = [
    inputs.jovian.nixosModules.jovian
    ./plasma.nix
  ];
  config = {
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
