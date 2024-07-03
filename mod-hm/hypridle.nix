{ pkgs, config, inputs, ... }: {
  config = {
    services.hypridle = {
        enable = true;
        settings = {
          general = {
            before_sleep_cmd = "swaylock";
          };
        };
      };
    
    programs.swaylock = {
      enable = true;
    };
  };
}