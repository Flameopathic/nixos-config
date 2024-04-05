{ config, pkgs, inputs, ... }: {
	home.packages = with pkgs; [
		discord
		beeper
		unityhub
		prismlauncher
	];
}
