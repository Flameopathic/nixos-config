{ lib, ... }:
{
  config = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "swaylock";
        };
      };
    };

    programs = {
      swaylock = {
        enable = true;
        settings = {
          image = lib.mkForce ../mod/ui/theme/rose-pine/resources/ventures-logo-wide.png;
          scaling = "fill";
        };
      };
      hyprlock = {
        enable = false;
        settings = {
          general = {
            immediate_render = true;
            hide_cursor = true;
            ignore_empty_input = true;
            no_fade_in = true;
          };
          # background = {
          #   path = "/etc/nixos/resources/bay.png";
          # };

          input-field = {
            size = "600, 100";
            position = "0, 0";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "password for flame";
            shadow_passes = 2;
          };
        };
      };
    };
  };
}
