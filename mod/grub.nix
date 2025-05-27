{ ... }:
{
  config.boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      splashImage = ../resources/outer-wilds/title.png;
      splashMode = "normal";
    };
    efi.canTouchEfiVariables = true;
  };
}
