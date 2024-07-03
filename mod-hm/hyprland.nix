{ config, pkgs, lib, ... }:
let
  cfg = config.flame.hyprland;
in {
  imports = [
    ./waybar.nix
    ./hypridle.nix
  ];

  options.flame.hyprland = {
    monitor = lib.mkOption {
      default = [ ", highres, auto, auto" ];
      description = "list of monitor configuration(s)";
    };
    wallpaper = lib.mkOption {
      default = "leafy-moon.png";
      description = "name of image in ../resources";
    };
  };
  
  config = {
    # notification daemon
    services.mako = {
      enable = true;
      anchor = "top-center";
    };

    # drun
    programs.wofi = {
      enable = true;
    };

    # packages
    home.packages = with pkgs; [
      swww
      brillo
      networkmanagerapplet
      hyprshot
      pasystray
    ];

    # main config
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        exec-once = "waybar & swww-daemon & mako & nm-applet & pasystray &";
        exec = "swww img /etc/nixos/resources/" + cfg.wallpaper;
        "$mod" = "SUPER";
        monitor = cfg.monitor;
        "misc:disable_hyprland_logo" = true;

        input = {
          # should make steam popups happier
          # follow_mouse = 1;
          # mouse_refocus = false;

          repeat_delay = 350; # ms before key repeat

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
          allow_tearing = true;
          border_size = 3;
          gaps_out = 15;
          resize_on_border = true;
        };
        decoration = {
          rounding = 3;
        };
        cursor = {
          inactive_timeout = 15;
        };

        # windows
        dwindle = {
          smart_split = true;
        };

        # animations
        animation = [
          "workspaces, 1, 2, default, slidevert"
          "windowsMove, 1, 2, default"
        ];

        # env = "WLR_DRM_NO_ATOMIC,1";

        # binds
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bindl = [ # works even when a lockscreen is active
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
          ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
          ", switch:Lid Switch, exec, hyprlock"
          ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, preferred, 1920x0, auto\""
        ];
        bindel = [ # repeat and work on lockscreen
          # brightness and volume
          ", XF86MonBrightnessDown, exec, brillo -q -u 150000 -U 2"
          ", XF86MonBrightnessUp, exec, brillo -q -u 150000 -A 2"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ];
        bind = [
          # programs
          "$mod, R, exec, wofi --normal-window --show drun --insensitive --allow-images"
          "$mod SHIFT, s, exec, hyprshot -m region -o ~/pic/ss"
          "$mod, q, exec, kitty"
          "$mod, p, exec, hyprlock"
          "CTRL SHIFT $mod ALT, l, exec, firefox --new-tab https://linkedin.com/"

          # windows
          "$mod, c, killactive,"
          "$mod, i, exec, hyprctl kill"
          "$mod, n, togglefloating,"
          "$mod, b, togglesplit,"
          "$mod, f, fullscreen, 0"
          "$mod SHIFT, f, fakefullscreen, 0"

          "$mod, m, exit,"

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
        	"$mod, o, togglespecialworkspace, magic"
        	"$mod SHIFT, o, movetoworkspace, special:magic"

          # workspaces
          "$mod SHIFT, j, workspace, +1"
          "$mod SHIFT, k, workspace, -1"
          "$mod SHIFT CTRL, j, movetoworkspace, +1"
          "$mod SHIFT CTRL, k, movetoworkspace, -1"
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
              "$mod SHIFT CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
        	  ]
          ) 10)
        );
      };
    };
  };
}
