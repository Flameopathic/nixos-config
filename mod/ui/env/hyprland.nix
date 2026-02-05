{ ... }:
{
  imports = [ ../dm/greetd.nix ];
  config = {
    programs.hyprland.enable = true;
    security.pam.services.swaylock = { };
    home-manager.sharedModules = [ ../../../mod-hm/hyprland.nix ];
  };
}
