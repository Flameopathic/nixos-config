{ config, lib, ... }:

with lib;

let
	cfg = config.flame.thermald;
in {
	options.flame.thermald = {
		enable = mkEnableOption "thermald config";
	};
	
	config = mkIf cfg.enable {
		services.thermald = {
			enable = true;
			configFile = ../../resources/thermal-conf.xml;
		};
	};
}
