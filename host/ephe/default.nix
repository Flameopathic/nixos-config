{ inputs }:
{
  modules = [
    (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
    ../../mod/ssh-server.nix
    ../../mod/hyprland.nix
    ../../mod/rose-pine.nix
    ../../mod/ui.nix
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
