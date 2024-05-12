{ config, pkgs, inputs, lib, ... }:

with lib;

let
	cfg = config.flame.ui-apps;
in {
	options.flame.ui-apps = {
	  enable = mkEnableOption "most used ui apps";
	};
	
	config = mkIf cfg.enable {
		home.packages = with pkgs; [
			unstable.discord-screenaudio
			unstable.obsidian
			vlc
			beeper
			unityhub
			prismlauncher
			gnome.file-roller
			xfce.thunar
		];
		programs = {
			kitty = {
				enable = true;
			};
	    firefox = {
	      enable = true;
	      profiles = {
	        default = {
	      	  id = 0;
	      	  name = "default";
	      	  isDefault = true;
	      	  settings = { # much of this comes from https://brainfucksec.github.io/firefox-hardening-guide
	            "browser.aboutConfig.showWarning" = false;
							"browser.startup.page" = 3;
							"browser.newtabpage.enabled" = false;
							"browser.newtab.preload" = false;
							"browser.newtabpage.activity-stream.telemetry" = false;
							"browser.newtabpage.activity-stream.feeds.snippets" = false;
							"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
							"browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
							"browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
							"browser.newtabpage.activity-stream.showSponsored" = false;
							"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
							"browser.newtabpage.activity-stream.default.sites" = "";
							"geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
							"geo.provider.use_gpsd" = false;
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
							"toolkit.telemetry.archibev.enabled" = false;
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
							"captivedetect.canonicalURL" = "";
							"network.captive-portal-service.enabled" = false;
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
							# could disable password saving
							"browser.cache.disk.enable" = false;
							"browser.sessionstore.privacy_level" = 2;
							"browser.sessionstore.resume_from_cache" = false;
							"browser.pagethumbnails.capturing_disabled" = true;
							"browser.shell.shortcutFavicons" = false;
							"browser.helperApps.deleteTempFileOnExit"= true;
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
							"webgl.disabled" = true;
							"media.autoplay.default" = 5;
							"media.eme.enabled" = false;
							"browser.download.useDownloadDir" = false;
							"browser.download.manager.addToRecentDocs" = false;
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
							"privacy.resistFingerprinting" = true; # could be a breaking change
							
							# i don't quite get these next two
							"privacy.window.maxInnerWidth" = 1600;
							"privacy.window.maxInnerHeight" = 900; 
							"privacy.resistFingerprinting.block_mozAddonManager" = true;
							"browser.display.use_system_colors" = false;
							"browser.startup.blankWindow" = false;
							
							"network.dns.echconfig.enabled" = true;
							"network.dns.http3_echconfig.enabled" = true;
							"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
	      	    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
	      	    "privacy.annotate_channels.strict_list.enabled" = true;
	      	    "privacy.donottrackheader.enabled" = true;
	      	    "privacy.fingerprintingProtection" = true;
	            "privacy.globalprivacycontrol.enabled" = true;
	      	    "privacy.query_stripping.enabled" = true;
	      	    "privacy.query_stripping.enabled.pbmode" = true;
	      	    "privacy.trackingprotection.enabled" = true;
	      	    "signon.firefoxRelay.feature" = "disabled";
	      	    "toolkit.telemetry.pioneer-new-studies-available" = false;
	      	    "trailhead.firstrun.didSeeAboutWelcome" = true;
							
	      	  };
	         #  extensions = with inputs.firefox-addons.${pkgs.system}; [
	         #    ublock-origin
	         #   darkreader
	       	 #  ];
	      	};
	      };
	    };
		};
	  services = {
	    gnome-keyring.enable = true; # necessary for automatically logging back into nextcloud-client
	    nextcloud-client.enable = true;
	  };
	};
}
