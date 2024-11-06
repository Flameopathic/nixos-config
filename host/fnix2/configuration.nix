{ pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
    };
  };

  hardware.logitech.wireless.enable = true;

  environment.systemPackages = with pkgs; [
    solaar
    (pkgs.callPackage ../../pkgs/wl-clicker { })
  ];

  networking.interfaces.eno1.wakeOnLan.enable = true;

  system.stateVersion = "23.11"; # shouldn't be changed
}
