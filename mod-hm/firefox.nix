{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.betterfox.modules.homeManager.betterfox ];

  config.programs.firefox = {
    enable = true;
    betterfox = {
      enable = true;
      profiles.default.enableAllSections = true;
    };
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.page" = 3;
          "trailhead.firstrun.didSeeAboutWelcome" = true;

          # manages what is in the ui
          "browser.uiCustomization.state" =
            "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"sponsorblocker_ajay_app-browser-action\",\"dearrow_ajay_app-browser-action\",\"_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action\",\"videospeed-firefox_lelesius_eu-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"simple-tab-groups_drive4ik-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"addon_darkreader_org-browser-action\",\"dearrow_ajay_app-browser-action\",\"simple-tab-groups_drive4ik-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"videospeed-firefox_lelesius_eu-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\"],\"currentVersion\":20,\"newElementCount\":2}";
        };
        extensions.packages =
          with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            adaptive-tab-bar-colour
            ublock-origin
            better-canvas
            clearurls
            darkreader
            dearrow
            sponsorblock
            videospeed
            chameleon-ext
            zybooks-auto
          ];
        search = {
          default = "StartPage";
          force = true;
          engines = {
            "StartPage" = {
              urls = lib.singleton {
                template = "https://www.startpage.com/sp/search?query={searchTerms}&abp=1&abe=1&t=device&lui=english&sc=9U7yOJI1JTpD10&cat=web&abd=1&abe=1&prfe=023d551d26228e018885ffa63615e6febfc9e2c5d8505b4a5f0240951f237a5f076f7f1377e514d6af20992915444bff21494004468200cf5794216ebf6c8c0627c5cfd21b8c1e96f8da4e09a1d0520d";
              };

              icon = "https://www.startpage.com/sp/cdn/favicons/favicon--default.ico";
              definedAliases = [ "@s" ];
            };

            "Privau" = {
              urls = lib.singleton {
                template = "https://priv.au/search?q={searchTerms}";
              };

              icon = "https://priv.au/favicon.ico";
              definedAliases = [ "@p" ];
            };

            "Nix Packages" = {
              urls = lib.singleton {
                template = "https://search.nixos.org/packages?type=packages&query={searchTerms}";
              };

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "noogle" = {
              urls = lib.singleton {
                template = "https://noogle.dev/q?term={searchTerms}";
              };

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@ng" ];
            };

            "Wikipedia" = {
              urls = lib.singleton {
                template = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}";
              };

              icon = "https://wikipedia.org/favicon.ico";
              definedAliases = [ "@w" ];
            };
            "Home Manager" = {
              urls = lib.singleton {
                template = "https://home-manager-options.extranix.com/?query={searchTerms}";
              };

              icon = "https://home-manager-options.extranix.com/favicon.ico";
              definedAliases = [ "@h" ];
            };
          };
        };
        bookmarks = {
          force = true;
          settings = [
            {
              name = "toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "EMAG";
                  tags = [ "school" ];
                  url = "https://waltscientific.weebly.com/ap-physics-c-emag.html";
                }
              ];
            }
            {
              name = "CUPS";
              url = "http://localhost:631/";
            }
            {
              name = "syncthing";
              url = "http://127.0.0.1:8384/";
            }
          ];
        };
      };
      fallback = {
        id = 1;
        name = "fallback";
      };
    };
  };
}
