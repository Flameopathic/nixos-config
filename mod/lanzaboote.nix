{ inputs, config, pkgs, ... }: {
	imports = [
		inputs.lanzaboote.nixosModules.lanzaboote
	];

	boot.lanzaboote = {
		enable = true;
		pkiBundle = "/etc/secureboot";
	};
}
