{ config, pkgs, inputs, ... }: {
  home.username = "flame";
  home.homeDirectory = "/home/flame";

  home.packages = with pkgs; [
    neofetch
    # discord
    # beeper
    kitty
    # unityhub
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
    helix = {
      enable = true;
      defaultEditor = true;
    };
  };

  services = {
    gnome-keyring.enable = true; # necessary for automatically logging back into nextcloud-client
    nextcloud-client.enable = true;
  };

  home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
  programs.home-manager.enable = true;
}
