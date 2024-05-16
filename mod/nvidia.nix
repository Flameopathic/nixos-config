{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.flame.nvidia;
in {
	options.flame.nvidia = {
		enable = mkEnableOption "settings pertinent to nvidia machines";
	};

	config = mkIf cfg.enable {
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
			};
		};
	};
}
