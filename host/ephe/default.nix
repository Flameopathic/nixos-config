{ inputs }:
{
  modules = [
    (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
    ../../mod/server/ssh.nix
    ../../mod/ui/theme/rose-pine
    ../../mod/ui
    ../../mod/ui/env/hyprland.nix
    {
      networking.wireless.enable = false;
    }
  ];
  home-modules = [
    ../../mod-hm/ui-apps.nix
    (
      { pkgs, ... }:
      {
        home.packages = [ pkgs.gparted ];
        flame.ui.minimal = true;
        home.stateVersion = "24.11";
      }
    )
  ];
}
