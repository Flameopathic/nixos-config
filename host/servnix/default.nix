{
  system = "aarch64-linux";
  modules = [
    ../../mod/av.nix
    ../../mod/boot/rpi-boot.nix
    ../../mod/server/ssh.nix
    ../../mod/syncthing.nix
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
