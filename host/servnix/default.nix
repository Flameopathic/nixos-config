{
  system = "aarch64-linux";
  modules = [
    ../../mod/rpi-boot.nix
    ../../mod/ssh-server.nix
    ../../mod/syncthing.nix
    ../../mod/av.nix
    {
      flame = {
        syncthing.server = true;
        ssh-server.openFirewall = true;
      };

      time.timeZone = "US/Eastern";
      system.stateVersion = "23.11"; # read docs before changing
    }
  ];
  home-modules = [
    {
      home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
    }
  ];
}
