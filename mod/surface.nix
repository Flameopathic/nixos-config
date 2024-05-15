{ config, inputs, pkgs, lib, ... }:

with lib;

let
	cfg = config.flame.surface;
in {
	options.flame.surface = {
		enable = mkEnableOption "Microsoft Surface config";
	};

	config = mkIf cfg.enable {
		services.iptsd.enable = true;
		environment.systemPackages = [ pkgs.surface-control ];
	};
}
