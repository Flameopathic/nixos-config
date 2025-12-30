{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 7 --optimise";
    };
    flake = "/etc/nixos";
  };
  home.packages = [
    (pkgs.writeShellApplication {
      # credit: Janik-Haag
      name = "nos";
      runtimeInputs = with pkgs; [
        nh
      ];
      text = ''
        nh os switch
      '';
    })
  ];
}
