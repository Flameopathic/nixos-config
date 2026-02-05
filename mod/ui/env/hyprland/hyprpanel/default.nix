{ pkgs, ... }:
{
  # necessary for icon alignment
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  home-manager.sharedModules = [ ./hm.nix ];
}
