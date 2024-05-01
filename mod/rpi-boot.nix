{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.flame.rpi-boot;
in {
  options.flame.rpi-boot = {
    enable = mkEnableOption "boot configuration for raspberry pi";
    overclock = mkEnableOption "overclock, set up for pi 4";
  };

  config = mkIf cfg.enable {
    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;
    environment.systemPackages = [ pkgs.libraspberrypi ];

  	boot.loader.raspberryPi.firmwareConfig = if cfg.overclock then ''
  	  arm_freq=2000
  		over_voltage=6
  		gpu_freq=750
  	'' else "";
  };
}
