{ config, lib, ... }:

with lib;

let
	cfg = config.flame.remote-builder;
in {
	options.flame.remote-builder = {
		enable = mkEnableOption "set up machine for remote building";
	};
	
	config = mkIf cfg.enable {
		boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
	};
}
