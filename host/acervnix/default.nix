{ inputs }:
{
  modules = [
    inputs.disko.nixosModules.disko
    ../../host/acervnix/disk-config.nix
    ../../mod/sd-boot.nix
    ../../mod/ssh-server.nix
    ../../mod/laptop-server.nix
    {
      system.stateVersion = "24.11";
    }
  ];
  home-modules = [
    {
      home.stateVersion = "24.05"; # home manager can be updated without changing this - read documentation
    }
  ];
}
