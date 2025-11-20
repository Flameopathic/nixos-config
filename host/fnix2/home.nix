{ lib, ... }:
{
  home.sessionVariables = {
    GDK_SCALE = 2;
  };

  wayland.windowManager.hyprland.settings.exec-once =
    lib.mkForce "swaylock & swww-daemon & mako & nm-applet & pasystray & spotify";

  home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
}
