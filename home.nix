{ config, pkgs, inputs, ... }: {
  home.username = "flame";
  home.homeDirectory = "/home/flame";

  home.packages = with pkgs; [
    neofetch
    discord
    beeper
    kitty
    swww
    waybar
  ];

  gtk = {
    enable = true;
  };

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
          #extensions = with inputs.firefox-addons.${pkgs.system}; [
          #  ublock-origin
	  #  darkreader
	  #];
	};
      };
    };
    rofi = {
      enable = true;
      theme = "fancy";
    };
  };

  services = {
    gnome-keyring.enable = true; # necessary for automatically logging back into nextcloud-client
    nextcloud-client.enable = true;
    mako = {
      enable = true;
      anchor = "top-center";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = ''
        waybar &
	swww init &
	nextcloud-client &
	beeper &
	mako &
      '';
      "$mod" = "SUPER";
      "monitor" = ",highres,auto,1";

      input = {
        # should make steam popups happier
        follow_mouse = 1;
	mouse_refocus = false;
      };
           
      bindm = [
        "$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
      ];
      bind = [
        # programs
        "$mod, F, exec, firefox"
	", Print, exec, grimblast copy area"
	"$mod, Q, exec, kitty"
	"$mod, C, killactive,"
	"$mod, M, exit,"
	"$mod, V, togglefloating,"
	"$mod, R, exec, rofi -show drun"
	"$mod, J, togglesplit,"

	# focus
	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"

        # special workspace
	"$mod, S, togglespecialworkspace, magic"
	"$mod SHIFT, S, movetoworkspace, special:magic"
      ] ++ (
        # makes 1-10 workspace bindings
	builtins.concatLists (builtins.genList (
	  x: let
	    ws = let
	      c = (x + 1) / 10;
	    in
	      builtins.toString (x + 1 - (c * 10));
          in [
	    "$mod, ${ws}, workspace, ${toString (x + 1)}"
	    "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
	  ]
        ) 10)
      );
    };
  };

  home.stateVersion = "23.11"; # home manager can be updated without changing this - read documentation
  programs.home-manager.enable = true;
}
