{ config, pkgs, inputs, ... }: {
	services = {
		iptsd = {
			enable = true;
			Touch.DisableOnStylus = true;
		};
	};
}
