{ config, inputs, pkgs, ... }: {
	services.thermald = {
		enable = true;
		configFile = ../../resources/thermal-conf.xml;
	};
}
