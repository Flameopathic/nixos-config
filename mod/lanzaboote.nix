{ inputs, ... }:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  config.boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
