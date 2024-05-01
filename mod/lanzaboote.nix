{ inputs, config, lib, ... }:

with lib;

let
	cfg = config.flame.lanzaboote;
in {
	imports = [
			inputs.lanzaboote.nixosModules.lanzaboote
	];

	options.flame.lanzaboote = {
		enable = mkEnableOption "enable Lanzaboote with secure boot";
	};
	
	config = mkIf cfg.enable {
		boot.lanzaboote = {
			enable = true;
			pkiBundle = "/etc/secureboot";
		};
	};
}
