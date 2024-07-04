{ ...  }: {
  programs = {
    steam.enable = true;
  };

  services.logind = {
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
  };

  system.stateVersion = "23.11";
}

