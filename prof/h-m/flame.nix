{ config, pkgs, inputs, ... }: {
  home.username = "flame";
  home.homeDirectory = "/home/flame";

  home.packages = with pkgs; [
    neofetch
    nerdfonts
  ];

  programs = {
    git = {
      enable = true;
      userName = "Flameopathic";
      userEmail = "flameopathic@gmail.com";
      extraConfig = {
        init.defaultBranch = "main"; # makes `git init` simpler
        safe.directory = "/etc/nixos"; # make sure to chown .git to an admin
      };
    };
    bash = {
      enable = true;
      enableCompletion = true;
    };
    helix = {
      enable = true;
      defaultEditor = true;
    };
  };

  home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
  programs.home-manager.enable = true;
}
