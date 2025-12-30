{ ... }:
{
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
      graphics = {
        enable = true;
      };
      nvidia = {
        open = false;
        modesetting.enable = true;
      };
    };
  };
}
