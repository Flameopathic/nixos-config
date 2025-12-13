{
  config,
  pkgs,
  lib,
  ...
}:
{
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
      wol
      ncdu
    ];

    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            name = "Flameopathic";
            email = "flameopathic@gmail.com";
          };
          init.defaultBranch = "master";
          safe.directory = "/etc/nixos"; # make sure to chown .git to an admin
        };
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          snrbs = lib.mkDefault "sudo nixos-rebuild switch";
          conf = "cd /etc/nixos";
          ".." = "cd ..";
          ssh = "TERM=xterm ssh";
          sctl = "systemctl";
          jctl = "journalctl";
          yt-dlm = "yt-dlp -x --audio-format mp3 --embed-subs --embed-thumbnail --embed-metadata";
        };
        history = {
          size = 50000;
          expireDuplicatesFirst = true;
        };
        prezto = {
          enable = true;
          prompt.theme = "paradox";
        };
      };
    };

    xdg.userDirs = {
      download = "${config.home.homeDirectory}/dld";
      pictures = "${config.home.homeDirectory}/pic";
      music = "${config.home.homeDirectory}/mus";
    };

    programs.home-manager.enable = true;
  };
}
