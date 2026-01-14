{ config, lib, ... }:
let
  cfg = config.flame.ssh-server;
in
{
  options.flame.ssh-server = {
    openFirewall = lib.mkEnableOption "open firewall ports for remote ssh connection";
    pubKeys = lib.mkOption {
      default = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILc5oDe4Uk3ZgEIENiQL7gZIv1FLFh37iPs9zxrrizfP flame"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBIw9lGau1jJof3vKpQ66e/v/eThjxuKclcEaqvi+gun flame"
      ];
    };
  };

  config = lib.mkMerge [
    {
      services = {
        openssh = {
          enable = true;
          # best practice is to require public-key authentication
          settings.PasswordAuthentication = false;
          settings.KbdInteractiveAuthentication = false;
        };
      };
      users.users = {
        flame.openssh.authorizedKeys.keys = cfg.pubKeys;
      };
    }
    (lib.mkIf cfg.openFirewall {
      networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall (
        lib.singleton 53180
      );
      services = {
        openssh.ports = [
          22
          53180
        ];
        fail2ban.enable = true;
      };
    })
  ];
}
