{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.flame.hyprland;
in
{
  imports = [
    ./waybar.nix
    ./hypridle.nix
  ];

  options.flame.hyprland = {
    monitor = lib.mkOption {
      default = [ ", highres, auto, auto" ];
      description = "list of monitor configuration(s)";
    };
  };

  config = {
    # notification daemon
    services.mako = {
      enable = true;
      settings = {
        anchor = "top-center";
        border-radius = 3;
        border-size = 3;
      };
    };

    # drun
    programs.tofi = {
      enable = true;
      settings = {
        fuzzy-match = true;
        drun-launch = true;

        # fullscreen
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 10;
        num-results = 7;

        font-size = lib.mkForce 20;
      };
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
      plugins = [
        pkgs.hyprlandPlugins.hyprexpo
      ];
      settings = {
        exec-once = "swaylock & swww-daemon & mako & nm-applet & pasystray";
        exec = "pkill waybar; waybar & swww img ${config.stylix.image}";

        monitor = cfg.monitor;
        "misc:disable_hyprland_logo" = true;

        input = {
          repeat_delay = 350; # ms before key repeat

          touchpad = {
            natural_scroll = true;
          };
        };
        device = {
          name = "logitech-mx-master-3-1";
          sensitivity = .75;
        };
        gestures = {
          workspace_swipe = true;
        };
        "windowrulev2" = [
          "stayfocused,class:(tofi)"
        ]; # makes tofi stay

        # plugins
        plugin.hyprexpo = {
          colums = 3;
          gap_size = 5;
          bg_col = "rgb(${config.lib.stylix.colors.base01})";
          workspace_method = "first 1";
          gesture_distance = 300;
        };

        # appearance
        general = {
          allow_tearing = true;
          border_size = 3;
          gaps_in = 4;
          gaps_out = 4;
          resize_on_border = true;
        };
        decoration = {
          rounding = 9;
          shadow.enabled = false;
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

        # xwayland scaling fixes
        xwayland = {
          force_zero_scaling = true;
        };
        env = [ "XCURSOR_SIZE,${builtins.toString config.stylix.cursor.size}" ];

        # binds
        "$mod" = "SUPER";
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bindl = [
          # works even when a lockscreen is active
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
          ", switch:on:Lid Switch, exec, systemctl suspend"
        ];
        bindel = [
          # repeat and work on lockscreen
          # brightness and volume
          ", XF86MonBrightnessDown, exec, brillo -q -u 150000 -U 2"
          ", XF86MonBrightnessUp, exec, brillo -q -u 150000 -A 2"
          "$mod, XF86MonBrightnessDown, exec, brillo -p -u 150000 -U 2"
          "$mod, XF86MonBrightnessUp, exec, brillo -p -u 150000 -A 2"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ];

        bind = [
          # programs
          "$mod, tab, exec, pkill -SIGUSR1 waybar"
          "$mod, R, exec, tofi-drun"
          "$mod SHIFT, s, exec, hyprshot -m region -o ~/pic/ss"
          "$mod, return, exec, foot"
          "$mod, p, exec, swaylock"
          "$mod, t, exec, toggle-theme"
          "CTRL SHIFT $mod ALT, l, exec, firefox --new-tab https://linkedin.com/"

          # windows
          "$mod, q, killactive,"
          "$mod, i, exec, hyprctl kill"
          "$mod, n, togglefloating,"
          "$mod, b, togglesplit,"
          "$mod, f, fullscreen, 0"
          "$mod, SUPER_L, hyprexpo:expo, toggle"
          # "$mod SHIFT, f, fakefullscreen, 0"

          # gaming mode
          "$mod, e, setfloating"
          "$mod, e, movetoworkspace, 5"
          "$mod, e, moveactive, exact 25% 0%"
          "$mod, e, resizeactive, exact 50% 100%"
          "$mod, e, exec, hyprctl setprop active dimaround 1"
          "$mod, e, exec, hyprctl setprop active renderunfocused"

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
          "$mod, w, togglespecialworkspace, magic"
          "$mod SHIFT, w, movetoworkspace, special:magic"

          # workspaces
          "$mod SHIFT, j, workspace, +1"
          "$mod SHIFT, k, workspace, -1"
          "$mod SHIFT CTRL, j, movetoworkspace, +1"
          "$mod SHIFT CTRL, k, movetoworkspace, -1"
        ]
        ++ (
          # makes 1-10 workspace bindings
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                "$mod SHIFT CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
      };
    };
  };
}
