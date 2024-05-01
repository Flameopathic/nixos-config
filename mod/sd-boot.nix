{ config, lib, ... }:

with lib;

let
  cfg = config.flame.sd-boot;
in {
  options.flame.sd-boot = {
    enable = mkEnableOption "systemd boot loader";
  };
  
  config = mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = true;
      consoleMode = "max"; # makes console fill screen
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
