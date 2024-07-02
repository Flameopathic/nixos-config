{ pkgs, lib, ... }: {
  config = {
    home.username = "flame";
    home.homeDirectory = "/home/flame";

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
        };
      };
      kakoune = {
        enable = true;
        defaultEditor = true;
        plugins = with pkgs.kakounePlugins; [
          fzf-kak
          kakboard
          byline-kak
          smarttab-kak
          powerline-kak
          quickscope-kak
          auto-pairs-kak
          kakoune-rainbow
          kakoune-buffers
          kakoune-registers
          kakoune-state-save
        ];
        config = {
          autoReload = "yes";
          indentWidth = 2;
          numberLines = {
            enable = true;
            highlightCursor = true;
          };
          scrollOff = {
            columns = 10;
            lines = 10;
          };
          ui = {
            assistant = "none";
            enableMouse = true;
          };
        };
      };
    };    

    home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
    programs.home-manager.enable = true;
  };
}
