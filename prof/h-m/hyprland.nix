{ config, pkgs, inputs, ... }: {
  # notification daemon
  services.mako = {
    enable = true;
    anchor = "top-center";
  };

  # drun
  programs.wofi = {
    enable = true;
    # theme = "fancy";
  };

  # packages
  home.packages = with pkgs; [
    swww
    waybar
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
      "monitor" = ",highres,auto,auto";

      input = {
        # should make steam popups happier
        follow_mouse = 1;
      	mouse_refocus = false;
      };
      "windowrulev2" = "stayfocused,class:(wofi)"; # makes wofi stay
           
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
      	"$mod, R, exec, wofi --normal-window --show drun"
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
}
