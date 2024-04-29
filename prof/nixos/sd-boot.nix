{ config, pkgs, inputs, ... }: {
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max"; # makes console fill screen
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
