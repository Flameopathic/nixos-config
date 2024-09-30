{ ... }:
{
  config = {
    programs.hyprland.enable = true;
    security.pam.services.hyprlock = { };
    home-manager.users.flame.imports = [ ../mod-hm/hyprland.nix ];
  };
}
