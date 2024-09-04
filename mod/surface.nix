{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
    ./mobile.nix
  ];
  config.environment.systemPackages = [ pkgs.msr-tools ];
}
