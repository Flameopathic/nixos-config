{ config, ... }: {
	config = {
		services.xserver.videoDrivers = [ "nvidia" ];
	
		hardware = {
			graphics = {
				enable = true;
				enable32Bit = true;
			};
			nvidia = {
				modesetting.enable = true;
				package = config.boot.kernelPackages.nvidiaPackages.beta;
			};
		};
	};
}
