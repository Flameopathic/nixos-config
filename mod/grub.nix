{ ... }:
{
  config.boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      splashImage = ../resources/outerwildstitle.png;
      splashMode = "normal";
    };
    efi.canTouchEfiVariables = true;
  };
}
