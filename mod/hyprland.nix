{ ... }: {
  config = {
    programs.hyprland.enable = true;
    security.pam.services.swaylock = { };
    home-manager.users.flame.imports = [
      ../mod-hm/hyprland.nix
    ];
  };
}
