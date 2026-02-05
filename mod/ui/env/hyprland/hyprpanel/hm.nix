{ config, ... }:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = false;
    settings = {
      scalingPriority = "hyprland";
      bar = {
        customModules.storage.paths = [
          "/"
        ];
        autoHide = "fullscreen";

        launcher.autoDetectIcon = true;
        workspaces = {
          show_icons = false;
          showWsIcons = true;
          showApplicationIcons = true;
          applicationIconOncePerWorkspace = true;
          showAllActive = false;
          numbered_active_indicator = "underline";
          applicationIconEmptyWorkspace = " ";
        };
        network.showWifiInfo = true;
        bluetooth.label = true;
        clock = {
          format = "%a %b %d  %I:%M %p";
          showTime = true;
        };
        media = {
          show_label = true;
          show_active_only = true;
        };
        notifications = {
          show_total = false;
          hideCountWhenZero = false;
        };
      };
      theme = {
        font = {
          size = "1rem";
          name = "GeistMono Nerd Font";
          label = "GeistMono Nerd Font";
          style = "normal";
        };
        bar = {
          scaling = 100;
          margin_top = "0";
          margin_sides = "0.1em";
          transparent = true;
          location = "bottom";
          outer_spacing = "0";
          buttons = {
            y_margins = "0";
            spacing = "0.2em";
            padding_x = "0.6rem";
            padding_y = "0.1rem";
            radius = "0.6em";
            innerRadiusMultiplier = "0.4";
            separator.margins = "0.15em";
            workspaces.smartHighlight = true;
            modules.microphone.enableBorder = false;
            enableBorders = false;
            style = "default";
          };
          layer = "bottom";
          margin_bottom = ".3em";
          floating = true;
          menus = {
            menu = {
              dashboard.scaling = 90;
              notifications.height = "40em";
            };
            monochrome = false;
          };
        };
        osd = {
          enable = true;
          orientation = "vertical";
          location = "right";
        };
        matugen = true;
        matugen_settings.mode = "light";
      };
      notifications = {
        position = "bottom right";
        showActionsOnHover = true;
      };
      menus = {
        clock = {
          time = {
            military = false;
            hideSeconds = false;
          };
          weather = {
            location = "Los Angeles";
            enabled = false;
          };
        };
        dashboard = {
          controls.enabled = false;
          directories = {
            left = {
              directory1 = {
                label = "󰉍 dld";
                command = "bash -c \"xdg-open $HOME/dld/\"";
              };
              directory2 = {
                label = "󰉏 pic";
                command = "bash -c \"xdg-open $HOME/pic/\"";
              };
              directory3 = {
                label = "󰚝 prg";
                command = "bash -c \"xdg-open $HOME/prg/\"";
              };
            };
            right = {
              directory1 = {
                label = "󱧶 doc";
                command = "bash -c \"xdg-open $HOME/doc/\"";
              };
              directory2 = {
                command = "bash -c \"xdg-open $HOME/\"";
                label = "󱂵 Home";
              };
              directory3 = {
                label = "nixos-config";
                command = "bash -c \"xdg-open /etc/nixos\"";
              };
            };
          };
          shortcuts = {
            enabled = true;
            left = {
              shortcut1 = {
                icon = "";
                command = "";
                tooltip = "";
              };
              shortcut2 = {
                icon = "";
                command = "";
                tooltip = "";
              };
              shortcut3 = {
                icon = "";
                command = "";
                tooltip = "";
              };
              shortcut4 = {
                icon = "";
                command = "";
                tooltip = "";
              };
            };
            right = {
              shortcut1 = {
                icon = "";
                command = "";
                tooltip = "";
              };
              shortcut3 = {
                icon = "";
                command = "";
                tooltip = "";
              };
            };
          };
        };
        power = {
          lowBatteryNotification = true;
          lowBatteryThreshold = 15;
        };
        transition = "crossfade";
      };
      wallpaper.image = config.stylix.image;
    };
  };
}
