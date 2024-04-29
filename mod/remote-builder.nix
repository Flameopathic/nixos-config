{ config, pkgs, inputs, ... }: {
	boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
