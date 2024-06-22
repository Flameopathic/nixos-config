{ ... }: {
  config.boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max"; # makes console fill screen
    };
    efi.canTouchEfiVariables = true;
  };
}
