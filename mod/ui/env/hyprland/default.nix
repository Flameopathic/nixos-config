{ ... }:
{
  imports = [
    ../../dm/greetd.nix
    ./hyprpanel
  ];
  config = {
    programs.hyprland.enable = true;
    security.pam.services.swaylock = { };
    home-manager.sharedModules = [ ./hm.nix ];
  };
}
