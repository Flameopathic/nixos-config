{ config, pkgs, inputs, lib, ... }:

with lib;

let
  cfg = config.flame.hyprland;
in {
  options.flame.hyprland = {
    enable = mkEnableOption "hyprland setup and config";
    monitor = mkOption {
      default = [ ", highres, auto, auto" ];
      description = "list of monitor configuration(s)";
    };
  };
  
  config = mkIf cfg.enable {
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
      settings = {
        mainBar = {
          position = "bottom";
          spacing = 4;
          modules-left = [
            "hyprland/workspaces" 
            "hyprland/window"
          ];
          modules-right = [
            "pulseaudio"
            "network"
            "cpu"
            "memory"
            "temperature"
            "backlight"
            "battery"
            "clock"
            "tray"
            "bluetooth"
            "disk"
          ];
          tray.spacing = 10;
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };
          cpu = {
            format = "{usage}% ";
            tooltip = false;
          };
          memory.format = "{}% ";
          temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["" "" ""];
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["" "" "" "" ""];
          };
          network = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            onclick = "pavucontrol";
          };
        };
      };
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
      brillo
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
        monitor = cfg.monitor;
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
          # ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
          ", switch:Lid Switch, exec, swaylock"
          # ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, highres, auto, auto\""
        ];
        bindel = [ # repeat and work on lockscreen
          # brightness and volume
          ", XF86MonBrightnessDown, exec, brillo -q -u 150000 -U 5"
          ", XF86MonBrightnessUp, exec, brillo -q -u 150000 -A 5"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ];
        bind = [
          # programs
          "$mod, f, exec, firefox"
          "$mod, R, exec, wofi --normal-window --show drun"
        	", Print, exec, grimblast copy area"
        	"$mod, q, exec, kitty"
        	"$mod, c, killactive,"
        	"$mod, m, exit,"
        	"$mod, n, togglefloating,"
        	"$mod, j, togglesplit,"
          "$mod, p, exec, swaylock"

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
        	"$mod, s, togglespecialworkspace, magic"
        	"$mod SHIFT, s, movetoworkspace, special:magic"
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
  };
}
