{ config, pkgs, ... }: {
	config = {
		services.xserver.videoDrivers = [ "nvidia" ];
	
		hardware = {
			opengl = {
				enable = true;
				extraPackages = [ pkgs.glfw-wayland-minecraft ];
				driSupport = true;
				driSupport32Bit = true;
			};
			nvidia = {
				modesetting.enable = true;
				package = config.boot.kernelPackages.nvidiaPackages.beta;
			};
		};
	};
}
