{ config, pkgs, inputs, ... }: {
	boot.loader.raspberryPi.firmwareConfig = ''
	  arm_freq=2000
		over_voltage=6
		gpu_freq=750
	'';
}
