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
	      	  settings = {
	            "browser.aboutConfig.showWarning" = false;
	      	    "app.shield.optoutstudies.enabled" = false;
	      	    "browser.contentblocking.category" = "strict";
	            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
	      	    "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
	      	    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
	      	    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
	      	    "browser.urlbar.suggest.quicksuggest.nonsponsored" = true;
	      	    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
	      	    "datareporting.healthreport.uploadEnabled" = false;
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
	      	    "extensions.pocket.enabled" = false;
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
