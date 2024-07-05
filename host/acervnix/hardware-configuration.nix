{ lib, config, ... }: {
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" "sr_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm_intel" ];
  boot.extraModulePackages = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
}