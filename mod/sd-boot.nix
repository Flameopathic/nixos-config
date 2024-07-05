{ lib, config, ... }: 
let cfg = config.flame.sd-boot;
in {
  options.flame.sd-boot.enable = lib.mkOption {
    description = "systemd boot basic configuration";
    default = true;
  };
  
  config.boot.loader = lib.mkIf cfg.enable {
    systemd-boot = {
      enable = true;
      consoleMode = "max"; # makes console fill screen
    };
    efi.canTouchEfiVariables = true;
  };
}
