{
  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 7 --optimise";
      };
      flake = "/etc/nixos";
    };
    zsh.shellAliases.nos = "nh os switch";
  };
}
