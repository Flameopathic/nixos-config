{ inputs, ... }: {
	imports = [
		inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
		./mobile.nix
	];
}
