{ config, inputs, lib, ... }:

with lib;

let
	cfg = config.flame.home-manager;
in {
	imports = [
		inputs.home-manager.nixosModules.home-manager
	];
	
	options.flame.home-manager = {
		enable = mkEnableOption "flame home-manager configuration";
	};

	config = mkIf cfg.enable {
		home-manager = {
			useGlobalPkgs = true;
			useUserPackages = true;
			extraSpecialArgs = { inherit inputs; };
			users.flame = {
				imports = [
					../host/${config.networking.hostName}/home.nix
					../mod-hm/default.nix
				];
			};
		};
	};
}
