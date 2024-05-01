{ config, lib, ... }:

with lib;

let
  cfg = config.flame.hyprland;
in {
	options.flame.hyprland = {
		enable = mkEnableOption "system hyprland config";
	};

	config = mkIf cfg.enable {
		programs.hyprland.enable = true;
		security.pam.services.swaylock = {};
	};
}
