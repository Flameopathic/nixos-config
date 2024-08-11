{ pkgs, config, inputs, ... }: {
  config = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "swaylock; sleep 1";
        };
      };
    };

    programs.swaylock = {
      enable = true;
      settings = {
        image = "/etc/nixos/resources/bay.png";
        indicator = true;
      };
    };
  };
}

