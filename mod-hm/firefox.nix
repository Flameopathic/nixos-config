{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  config.programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          # much of this comes from https://brainfucksec.github.io/firefox-hardening-guide
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.page" = 3;
          "browser.newtabpage.enabled" = false;
          "browser.newtab.preload" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "geo.provider.use_geoclue" = false;
          "browser.region.network.url" = "";
          "browser.region.update.enabled" = false;
          "intl.accept_languages" = "en-US, en";
          "javascript.use_us_english_locale" = true;
          "app.update.auto" = false;
          "extensions.getAddons.showPane" = false;
          "extions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.ping-centre.telemetry" = false;
          "beacon.enabled" = false;
          "app.sheild.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "network.connectivity-service.enabled" = false;
          # could disable safe-browsing stuff here - i don't trust myself with that yet though
          "network.prefetch-next" = false;
          "network.dns.disablePrefetch" = true;
          "network.predictor.enabled" = false;
          "ntework.http.speculative-parallel-limit" = 0;
          "browser.places.speculativeConnect.enabled" = false;
          "netowrk.dns.disableIPv6" = true;
          "network.gio.supported-protocols" = "";
          "network.file.disable_unc_paths" = true;
          "permissions.manager.defaultsUrl" = "";
          "network.IDN_show_punycode" = true;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.fixup.alternate.enabled" = false;
          "browser.url.trimURLs" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          # could disable form autofill
          "browser.urlbar.quicksuggest.scenario" = "history";
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.enabled" = false;
          "browser.urlbar.trending.featureGate" = false;
          "browser.urlbar.addons.featureGate" = false;
          "browser.urlbar.mdn.featureGate" = false;

          # could disable password saving
          "browser.cache.disk.enable" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = false;
          "browser.sessionstore.privacy_level" = 2;
          "browser.sessionstore.resume_from_cache" = false;
          "browser.pagethumbnails.capturing_disabled" = true;
          "browser.shell.shortcutFavicons" = false;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;
          "security.OCSP.require" = true;
          "security.pki.sha1_enforcement_level" = 1;
          "security.cert_pinning.enforcement_level" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "network.http.referer.XOriginPolicy" = 2;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          "media.peerprotection.enabled" = false;
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          "media.peerconnection.ice.no_host" = true;
          "webgl.disabled" = false;
          "media.autoplay.default" = 5;
          "media.eme.enabled" = true;
          "browser.download.useDownloadDir" = false;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.lastDir" = "${config.xdg.userDirs.download}";
          "browser.contentblocking.category" = "strict";
          "privacy.partition.serviceWorkers" = true;
          "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
          "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = true;
          "dom.disable_open_during_load" = true;
          "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
          "extensions.pocket.enabled" = false;
          "extensions.Screenshots.disabled" = true;
          "pdfjs.enableScripting" = false;
          "privacy.userContext.enabled" = true;
          "extensions.enabledScopes" = 5;
          "extensions.webextensions.restrictedDomains" = "";
          "extensions.postDownloadThirdPartyPrompt" = false;
          # could sanitize after close
          "privacy.resistFingerprinting" = false;

          # i don't quite get these next two
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "browser.display.use_system_colors" = false;
          "browser.startup.blankWindow" = false;

          "network.dns.echconfig.enabled" = true;
          "network.dns.http3_echconfig.enabled" = true;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "privacy.annotate_channels.strict_list.enabled" = true;
          "privacy.donottrackheader.enabled" = true;
          "privacy.fingerprintingProtection" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.query_stripping.enabled" = true;
          "privacy.query_stripping.enabled.pbmode" = true;
          "privacy.trackingprotection.enabled" = true;
          "signon.firefoxRelay.feature" = "disabled";
          "toolkit.telemetry.pioneer-new-studies-available" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = true;

          # manages what is in the ui
          "browser.uiCustomization.state" =
            "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"sponsorblocker_ajay_app-browser-action\",\"dearrow_ajay_app-browser-action\",\"_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action\",\"videospeed-firefox_lelesius_eu-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"simple-tab-groups_drive4ik-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"addon_darkreader_org-browser-action\",\"dearrow_ajay_app-browser-action\",\"simple-tab-groups_drive4ik-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"videospeed-firefox_lelesius_eu-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\"],\"currentVersion\":20,\"newElementCount\":2}";
        };
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          darkreader
          sponsorblock
          dearrow
          videospeed
        ];
        search = {
          default = "StartPage";
          force = true;
          engines = {
            "StartPage" = {
              urls = lib.singleton {
                template = "https://startpage.com/sp/search?query={searchTerms}&lui=english&pfre=2fa6a015270de00b5fb2d150e6ee95efa7d9bc800cf5fd91dce2bc9654b5c383a748c79d2fdf53059a59216955de0be2824f524f52f88e741e676fc18d37a72928555b47bbfb09d56bbe8eab";
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
