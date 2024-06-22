{ config, lib, ... }:

with lib;

let
	cfg = config.flame.surface;
in {
	options.flame.surface = {
		enable = mkEnableOption "Microsoft Surface config";
	};

	config = mkIf cfg.enable {
		flame.mobile.enable = mkDefault true;
	};
}
