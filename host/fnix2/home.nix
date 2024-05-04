{ config, inputs, pkgs, lib, ... }: {
	flame = {
		user.enable = true;
		hyprland = {
			enable = true;
			# monitor = ["DP-3, 5120x1440@239.761002, auto, auto"];
		};
		ui-apps.enable = true;
	};
}
