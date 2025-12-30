{
  pkgs,
  ...
}:
{

  config = {
    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;
    environment.systemPackages = [ pkgs.libraspberrypi ];
  };
}
