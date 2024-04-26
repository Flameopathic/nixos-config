{ config, pkgs, inputs, ... }: {
  # notification daemon
  services.mako = {
    enable = true;
    anchor = "top-center";
  };

  # drun
  programs.wofi = {
    enable = true;
  };

  # waybar
  programs.waybar = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "808080";
    };
  };

  # packages
  home.packages = with pkgs; [
    swww
    brightnessctl
  ];
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
      "monitor" = "main, highres, auto, auto";
      "misc:disable_hyprland_logo" = true;

      input = {
        # should make steam popups happier
        follow_mouse = 1;
      	mouse_refocus = false;

        repeat_delay = 400; # ms before key repeat

        touchpad = {
          natural_scroll = true;
        };
      };
      gestures = {
        workspace_swipe = true;
      };
      "windowrulev2" = "stayfocused,class:(wofi)"; # makes wofi stay

      # appearance
      general = {
        border_size = 3;
        gaps_out = 15;
        resize_on_border = true;
        cursor_inactive_timeout = 15;
      };
      decoration = {
        rounding = 3;
      };
      
      # binds
      bindm = [
        "$mod, mouse:272, movewindow"
      	"$mod, mouse:273, resizewindow"
      ];
      bindl = [ # works even when a lockscreen is active
        # ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"main, disable\""
        ", switch:Lid Switch, exec, swaylock"
        # ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"main, highres, auto, auto\""
      ];
      bindel = [ # repeat and work on lockscreen
        # brightness and volume
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
      ];
      bindr = [ # triggers on key release - weird stuff can be done
      	"$mod, R, exec, pkill wofi || wofi --normal-window --show drun"
      ];
      bind = [
        # programs
        "$mod, F, exec, firefox"
      	", Print, exec, grimblast copy area"
      	"$mod, Q, exec, kitty"
      	"$mod, C, killactive,"
      	"$mod, M, exit,"
      	"$mod, V, togglefloating,"
      	"$mod, J, togglesplit,"
        "$mod, L, exec, swaylock"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"

      	# focus
      	"$mod, left, movefocus, l"
      	"$mod, right, movefocus, r"
      	"$mod, up, movefocus, u"
      	"$mod, down, movefocus, d"
      	"$mod, h, movefocus, l"
      	"$mod, l, movefocus, r"
      	"$mod, k, movefocus, u"
      	"$mod, j, movefocus, d"

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
}
