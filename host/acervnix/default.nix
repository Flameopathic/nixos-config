{ inputs }:
{
  modules = [
    ../../mod/boot/sd-boot.nix
    ../../mod/server/laptop.nix
    ../../mod/server/ssh.nix
    ./disk-config.nix
    inputs.disko.nixosModules.disko
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
