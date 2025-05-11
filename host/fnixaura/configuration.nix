{ pkgs, ... }: 
{
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_6_12;
  system.stateVersion = "24.11";
}