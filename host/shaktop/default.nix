{
  modules = [
    ../../mod/boot/sd-boot.nix
    ../../mod/hardware/remote-builder.nix
    ../../mod/server/laptop.nix
    ../../mod/server/mc.nix
    ../../mod/server/ssh.nix
    (
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.python3
          pkgs.steam-run
          pkgs.tmux
        ];
        flame.ssh-server.openFirewall = true;

        services.minecraft-servers.servers.eyecleft.enable = true;

        system.stateVersion = "23.11"; # Did you read the comment?
      }
    )
  ];
  home-modules = [
    {
      home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
    }
  ];
}
