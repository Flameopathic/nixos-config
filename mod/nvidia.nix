{ config, pkgs, ... }:
{
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelPackages = pkgs.unstable.linuxPackages;

    hardware = {
      graphics = {
        enable = true;
      };
      nvidia = {
        open = true;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };
  };
}
