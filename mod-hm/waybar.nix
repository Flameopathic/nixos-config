{ inputs, config, ... }:
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
          "hyprland/workspaces"
          "hyprland/window"
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
            today = "<span color='#${config.colorScheme.palette.base08}'><u>{}</u></span>";
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
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
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
          font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
      }

      window#waybar {
          background-color: rgba(${inputs.nix-colors.lib.conversions.hexToRGBString ", " config.colorScheme.palette.base00}, 0);
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
          background: rgba(${inputs.nix-colors.lib.conversions.hexToRGBString ", " config.colorScheme.palette.base03}, 0.2);
          border-radius: 6px;
          background: inherit;
          box-shadow: inset 0 -3px #${config.colorScheme.palette.base05};
      }

      #workspaces button.focused {
          background-color: #b4637a;
          box-shadow: inset 0 -3px #b4637a;
      }

      #workspaces button.urgent {
          background-color: #${config.colorScheme.palette.base08};
      }

      #clock,
      #battery,
      #cpu,
      #backlight,
      #tray,
      #workspaces,
      #window {
        padding: 0 10px;
        color: #${config.colorScheme.palette.base05};
        background-color: #${config.colorScheme.palette.base02};
        border: 3px solid #${config.colorScheme.palette.base03};
        border-radius: 6px;
      }


      #clock {
          color: #${config.colorScheme.palette.base0D};
      }

      #cpu {
          color: #${config.colorScheme.palette.base0C};
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #${config.colorScheme.palette.base0B};
      }

      #battery.critical:not(.charging) {
          background-color: #${config.colorScheme.palette.base08};
          color: #${config.colorScheme.palette.base03};
      }

      #tray {
          color: #${config.colorScheme.palette.base0B};
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #${config.colorScheme.palette.base08};
      }
    '';
  };
}
