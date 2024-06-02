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
        main = {
          layer = "top";
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

    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
      }

      window#waybar {
          background-color: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      button {
          /* Use box-shadow instead of border so the text isn't offset */
          box-shadow: inset 0 -3px transparent;
          /* Avoid rounded borders under each button name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ffffff;
      }

      /* you can set a style on hover for any module like this */
      #pulseaudio:hover {
          background-color: #a37800;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.focused {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #bluetooth,
      #disk,
      #tray {
        padding: 0 10px;
        color: #ffffff;
      }
      
      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          background-color: #64727D;
      }

      #battery {
          background-color: #ffffff;
          color: #000000;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      /* Using steps() instead of linear as a timing function to limit cpu usage */
      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background-color: #2ecc71;
          color: #000000;
      }

      #memory {
          background-color: #9b59b6;
      }

      #disk {
          background-color: #964B00;
      }

      #backlight {
          background-color: #90b1b1;
      }

      #network {
          background-color: #2980b9;
      }

      #network.disconnected {
          background-color: #f53c3c;
      }

      #pulseaudio {
          background-color: #f1c40f;
          color: #000000;
      }

      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }

      #temperature {
          background-color: #f0932b;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #2980b9;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #eb4d4b;
      }
    '';
    };

    programs.swaylock = {
      enable = true;
      settings = {
        color = "57327a";
      };
    };

    # packages
    home.packages = with pkgs; [
      swww
      brillo
      networkmanagerapplet
      hyprshot
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        exec-once = "waybar & swww img /etc/nixos/resources/lwp.png & mako & nm-applet &";
        "$mod" = "SUPER";
        monitor = cfg.monitor;
        "misc:disable_hyprland_logo" = true;

        input = {
          # should make steam popups happier
          # follow_mouse = 1;
          # mouse_refocus = false;

          repeat_delay = 400; # ms before key repeat

          touchpad = {
            natural_scroll = true;
          };
        };
        gestures = {
          workspace_swipe = true;
        };
        # "windowrulev2" = "stayfocused,class:(wofi)"; # makes wofi stay

        # appearance
        general = {
          allow_tearing = true;
          border_size = 3;
          gaps_out = 15;
          resize_on_border = true;
          cursor_inactive_timeout = 15;
        };
        decoration = {
          rounding = 3;
        };

        # env = "WLR_DRM_NO_ATOMIC,1";

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
          ", XF86MonBrightnessDown, exec, brillo -q -u 150000 -U 2"
          ", XF86MonBrightnessUp, exec, brillo -q -u 150000 -A 2"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ];
        bind = [
          # programs
          "$mod, f, fullscreen, 0"
          "$mod, R, exec, wofi --normal-window --show drun --insensitive --allow-images"
          ", Print, exec, grimblast copy area"
          "$mod, q, exec, kitty"
          "$mod, c, killactive,"
          "$mod, m, exit,"
          "$mod, n, togglefloating,"
          "$mod, j, togglesplit,"
          "$mod, p, exec, swaylock"

          "$mod SHIFT, s, exec, hyprshot -m region -o ~/Nextcloud/Pictures/Screenshots" # TODO: change screenshots folder

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
        	"$mod, o, togglespecialworkspace, magic"
        	"$mod SHIFT, o, movetoworkspace, special:magic"
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
