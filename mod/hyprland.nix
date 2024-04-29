{ config, pkgs, inputs, ... }: {
	programs.hyprland.enable = true;
	security.pam.services.swaylock = {};
}
