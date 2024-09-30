{ config, pkgs, ... }:
{
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];

    boot.kernelPackages = pkgs.unstable.linuxPackages;

    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      nvidia = {
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };
  };
}
