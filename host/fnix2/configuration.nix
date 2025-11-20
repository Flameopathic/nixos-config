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
