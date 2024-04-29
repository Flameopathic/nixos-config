{ config, pkgs, inputs, ... }: {
	services.xserver.videoDrivers = [ "nvidia" ];
	
	hardware = {
		opengl.enable = true;
		nvidia.modesetting.enable = true;
	};
}
