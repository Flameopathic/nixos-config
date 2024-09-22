{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
    ./mobile.nix
  ];
  config.environment.systemPackages = [
    pkgs.msr-tools
    ( pkgs.writeShellApplication {
        # credit: Janik-Haag
        name = "surface-msr-adjust";
        runtimeInputs = with pkgs; [ coreutils kitty msr-tools ];
        text = ''
          sudo -A modprobe msr; sudo wrmsr --all 0x601 0x408
        '';
      })
  ];
}
