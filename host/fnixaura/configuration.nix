{ pkgs, ... }: 
{
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
  system.stateVersion = "24.11";
}