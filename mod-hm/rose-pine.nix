{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./theme.nix
  ];
  config = {
    stylix = {
      polarity = lib.mkDefault "dark";
      image = lib.mkDefault (
        pkgs.fetchurl {
          url = "https://github.com/rose-pine/wallpapers/blob/main/rose_pine_contourline.png?raw=true";
          sha256 = "8OQCXMy27IImp1Oc/X4i14/8k9XjuuU+6clh0rRcAQY=";
        }
      );
      base16Scheme = lib.mkDefault {
        base00 = "191724";
        base01 = "1f1d2e";
        base02 = "26233a";
        base03 = "6e6a86";
        base04 = "908caa";
        base05 = "e0def4";
        base06 = "e0def4";
        base07 = "524f67";
        base08 = "eb6f92";
        base09 = "f6c177";
        base0A = "ebbcba";
        base0B = "31748f";
        base0C = "9ccfd8";
        base0D = "c4a7e7";
        base0E = "f6c177";
        base0F = "524f67";
      };
    };

    gtk = {
      iconTheme = {
        name = config.gtk.theme.name;
        package = pkgs.rose-pine-icon-theme;
      };
      theme = {
        name = lib.mkForce "rose-pine";
        package = lib.mkForce pkgs.rose-pine-gtk-theme;
      };
    };

    programs = {
      vesktop.vencord.theme = ''
        /**
        * @name Rosé Pine
        * @author blueb/Papa Quill
        * @authorId 403390454273409028
        * @version 3.0.9
        * @description All natural pine, faux fur and a bit of soho vibes for the classy minimalist.
        * @source https://github.com/rose-pine/discord
        * @updateUrl https://github.com/rose-pine/discord/blob/rose-pine.theme.css
        */

        @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@300..700&display=swap');
        :root {
        --Chat-Font-Used: '${config.stylix.fonts.sansSerif.name}', monospace ;
        --Chat-Font-Size: 14px;

            --font-primary: var(--Chat-Font-Used);
            --font-display: var(--Chat-Font-Used);
            --font-code: var(--Chat-Font-Used);
        }

        .theme-dark {
            --input-background: #1f1d2e;
            --bg-overlay-chat: #26233a;
            --home-background: #26233a;
            --modal-footer-background: #26233a;
            --primary-600: #26233a;
            --bg-mod-faint: #6e6af622;
            --card-secondary-bg: #00000060;
            --background-message-highlight: #6e6af633;
            --background-message-highlight-hover: #6e6af622;
            --background-mentioned: #6e6af633;
            --background-mentioned-hover: #6e6af622;
            --info-warning-foreground: #6e6af6;
            --background-primary: #26233a;
            --background-secondary: #1f1d2e;
            --background-secondary-alt: #26233a;
            --channeltextarea-background: #2c2842;
            --background-tertiary: #191724;
            --background-accent: #0000003a;
            --text-normal: #dad7fd;
            --text-spotify: #9ccfd8;
            --text-muted: #4f4c58;
            --text-link: #31748f;
            --background-floating: #1f1d2e;
            --header-primary: #e0def4;
            --header-secondary: #9ccfd8;
            --interactive-normal: #e0def4;
            --interactive-hover: #c4a7e7;
            --interactive-active: #e0def4;
            --ping: #eb6f92;
            --background-modifier-selected: #26233ab4;
            --scrollbar-thin-thumb: #191724;
            --scrollbar-thin-track: transparent;
            --scrollbar-auto-thumb: #191724;
            --scrollbar-auto-track: transparent;
        }

        .theme-light {
            --background-primary: #faf4ed;
            --background-secondary: #fffaf3;
            --background-secondary-alt: #f2e9de;
            --channeltextarea-background: #f2e9de;
            --background-tertiary: #f2e9de;
            --background-accent: #d7827e;
            --text-normal: #575279;
            --text-spotify: #575279;
            --text-muted: #6e6a86;
            --text-link: #286983;
            --background-floating: #f2e9de;
            --header-primary: #575279;
            --header-secondary: #575279;
            --header-spotify: #56949f;
            --interactive-normal: #575279;
            --interactive-hover: #6e6a86;
            --interactive-active: #575279;
        }

        .mainCard__0ec2c {
            background-color: var(--background-secondary) !important;
        }

        .body-2wLx-E,
        .headerTop-3GPUSF,
        .bodyInnerWrapper-2bQs1k,
        .footer-3naVBw,
        .panels-3wFtMD {
            background-color: var(--background-tertiary) !important;
        }

        .peopleColumn-1wMU14,
        .panels-j1Uci_,
        .peopleColumn-29fq28,
        .peopleList-2VBrVI,
        .content-2hZxGK,
        .header-1zd7se,
        .root-g14mjS .small-23Atuv .fullscreenOnMobile-ixj0e3 {
            background-color: var(--background-secondary) !important;
        }

        .textArea-12jD-V,
        .lookBlank-3eh9lL,
        .threadSidebar-1o3BTy,
        .scrollableContainer-2NUZem,
        .perksModalContentWrapper-3RHugb,
        .theme-dark .footer-31IekZ,
        .theme-light .footer-31IekZ {
            background-color: var(--background-tertiary) !important;
        }

        .numberBadge-2s8kKX,
        .base-PmTxvP,
        .baseShapeRound-1Mm1YW,
        .bar-30k2ka,
        .unreadMentionsBar-1Bu1dC,
        .mention-1f5kbO,
        .active-1SSsBb,
        .disableButton-220a9y {
            background-color: var(--ping) !important;
        }

        .lookOutlined-3sRXeN.colorRed-1TFJan {
            color: var(--ping) !important;
        }

        .header-3OsQeK,
        .container-ZMc96U {
            box-shadow: none !important;
            border: none !important;
        }

        .content-1gYQeQ,
        .layout-1qmrhw,
        .inputDefault-3FGxgL,
        .input-2g-os5,
        .input-2z42oC,
        .role-2TIOKu,
        .searchBar-jGtisZ {
            border-radius: 6px !important;
        }

        .layout-1qmrhw:hover,
        .content-1gYQeQ:hover {
            background-color: var(--background-modifier-selected) !important;
        }
      '';
    };

    flame.vscode.theme = lib.mkDefault "Rosé Pine (no italics)";

    xdg.desktopEntries.theme-switch = {
      name = "Toggle theme";
      exec = "toggle-theme";
      categories = [ "Utility" ];
    };

    specialisation.light.configuration = {
      stylix = {
        image = ../resources/lwp.png;
        polarity = "light";
        base16Scheme = {
          base00 = "FAF4ED";
          base01 = "FFFAF3";
          base02 = "F2E9DE";
          base03 = "9893A5";
          base04 = "797593";
          base05 = "575279";
          base06 = "575279";
          base07 = "CECACD";
          base08 = "B4637A";
          base09 = "EA9D34";
          base0A = "D7827E";
          base0B = "286983";
          base0C = "56949F";
          base0D = "907AA9";
          base0E = "EA9D34";
          base0F = "CECACD";
        };
      };

      gtk.theme.name = lib.mkOverride 10 "rose-pine-dawn";

      flame.vscode.theme = "Rosé Pine Dawn (no italics)";

      programs.bash.shellAliases.snrbs = "sudo nixos-rebuild switch && toggle-theme";

      home.packages = with pkgs; [
        # credit: Janik-Haag
        (hiPrio (writeShellApplication {
          name = "toggle-theme";
          runtimeInputs = with pkgs; [
            home-manager
            coreutils
            ripgrep
          ];
          text = ''
            "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate && hyprctl reload
          '';
        }))
      ];
    };
  };
}
