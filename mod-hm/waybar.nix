{ config, ... }:
{
  config.programs.waybar = {
    enable = true;
    settings = {
      main = {
        layer = "bottom";
        position = "bottom";
        height = 15;
        spacing = 4;
        margin-bottom = 4;
        margin-left = 4;
        margin-right = 4;
        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "cpu"
          "backlight"
          "battery"
          "clock"
          "tray"
        ];
        tray.spacing = 10;
        clock = {
          tooltip-format = "<tt>{calendar}</tt>";
          format-alt = "{:%Y-%m-%d}";
          calendar.format = {
            today = "<span color='#${config.lib.stylix.colors.base08}'><u>{}</u></span>";
          };
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% {icon} ";
          format-plugged = "{capacity}% {icon} ";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
      };
    };

    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: GeistMono NF;
          font-size: 13px;
      }

      window#waybar {
          background-color: transparent;
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

      #workspaces button:hover {
          background: #${config.lib.stylix.colors.base0A};
          border-radius: 6px;
          background: inherit;
          box-shadow: inset 0 -3px #${config.lib.stylix.colors.base04};
      }

      #workspaces button.active {
          background-color: #${config.lib.stylix.colors.base09};
          border-radius: 6px;
      }

      #workspaces button.urgent {
          background-color: #${config.lib.stylix.colors.base08};
      }

      #clock,
      #battery,
      #cpu,
      #backlight,
      #tray,
      #workspaces,
      #window {
        padding: 0 10px;
        color: #${config.lib.stylix.colors.base05};
        background-color: #${config.lib.stylix.colors.base02};
        border: 3px solid #${config.lib.stylix.colors.base03};
        border-radius: 12px;
      }


      #clock {
          color: #${config.lib.stylix.colors.base0D};
      }

      #cpu {
          color: #${config.lib.stylix.colors.base0C};
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #${config.lib.stylix.colors.base0B};
      }

      #battery.critical:not(.charging) {
          background-color: #${config.lib.stylix.colors.base08};
          color: #${config.lib.stylix.colors.base01};
      }

      #tray {
          color: #${config.lib.stylix.colors.base0B};
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #${config.lib.stylix.colors.base08};
      }
    '';
  };
}
