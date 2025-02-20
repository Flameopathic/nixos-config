{ lib, ... }:
{
  config.boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      splashImage = "/home/flame/prg/outer-wilds-grub/background.png";
      splashMode = "normal";
    };
    efi.canTouchEfiVariables = true;
  };
}
