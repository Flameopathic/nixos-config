{ pkgs, ... }:
{
  programs.steam.enable = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
