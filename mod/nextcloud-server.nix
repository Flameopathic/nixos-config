{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.flame.nextcloud;
in {
  options.flame.nextcloud = {
    enable = mkEnableOption "enable nextcloud server";
  };
  
  config = mkIf cfg.enable {
    # TODO: admin password
  
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud28;
      maxUploadSize = "500G";
      hostName = "drive.flameopathic.com";
    };
  };
}
