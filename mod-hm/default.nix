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
      (writeShellApplication { # credit: Janik-Haag
        name = "toggle-theme";
        runtimeInputs = with pkgs; [ home-manager coreutils ripgrep ];
        text =
          ''
            "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate
          '';
      })
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
          snrbs = "sudo nixos-rebuild switch";
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
          # wrapLines = {
          #   enable = true;
          #   indent = true;
          #   marker = "⏎";
          # };
        };
      };
    };

    # TODO: move to proper place
    xdg.desktopEntries = {
      shutdown = {
        name = "Shutdown now";
        exec = "shutdown now";
        comment = "Shutdown computer immediately";
        categories = [ "Utility" ];
      };
      reboot = {
        name = "Reboot";
        exec = "reboot";
        categories = [ "Utility" ];
      };
      theme-switch = lib.mkDefault {
        name = "Toggle theme";
        exec = "toggle-theme";
        categories = [ "Utility" ];
      };
    };

    

    home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
    programs.home-manager.enable = true;
  };
}
