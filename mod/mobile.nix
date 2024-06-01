{ config, pkgs, inputs, lib, ... }:

with lib;

let
  cfg = config.flame.mobile;
in {
  options.flame.mobile.enable = mkEnableOption "configuration for devices on the go";

  config = mkIf cfg.enable {
    security.pki.certificateFiles = [ ../resources/enterprise.pem ];
    flame.battery.enable = true;
  };
}
