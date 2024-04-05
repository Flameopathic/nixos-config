{ config, pkgs, inputs, ... }: {
	services.minecraft-server = {
		enable = true;
		eula = true;
		jvmOpts = "-Xmx6G -Xms6G";
		openFirewall = true;
	};
}
