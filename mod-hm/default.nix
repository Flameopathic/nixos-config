{ pkgs, lib, ... }: {
  config = {
    home = {
      username = "flame";
      homeDirectory = "/home/flame";
    };

    home.packages = with pkgs; [
      neofetch
      sbctl
      sshuttle
      nix-tree
      python3
    ];

    programs = {
      git = {
        enable = true;
        userName = "Flameopathic";
        userEmail = "flameopathic@gmail.com";
        extraConfig = {
          init.defaultBranch = "master";
          safe.directory = "/etc/nixos"; # make sure to chown .git to an admin
        };
      };
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          snrbs = lib.mkDefault "sudo nixos-rebuild switch";
          conf = "cd /etc/nixos";
          ".." = "cd ..";
          ssh = "TERM=xterm ssh";
          sctl = "systemctl";
          jctl = "journalctl";
        };
      };
      helix = {
        enable = true;
        defaultEditor = true;
      };
    };

    programs.home-manager.enable = true;
  };
}
