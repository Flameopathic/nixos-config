{ config, pkgs, inputs, ...  }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max"; # makes console fill screen
  };
  boot.loader.efi.canTouchEfiVariables = true;
 
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "fnix2";
  
  networking.networkmanager.enable = true;

  time.timeZone = "US/Eastern";

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  services.printing.enable = true;
  
  security.rtkit.enable = true; # not entirely sure what this does, but the wiki said it was good
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.gnome.gnome-keyring.enable = true; # makes nextcloud happy i suppose

  hardware = {
    bluetooth.enable = true;
    
    # for hyprland with nvidia 
    opengl.enable = true; 
    nvidia.modesetting.enable = true;
  };

  users.users.flame = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
  
  programs = {
    steam.enable = true;
    hyprland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];

  # stuff to make hyprland happier
  environment.sessionVariables = {
    # makes cursor visible
    WLR_NO_HARDWARE_CURSORS = "1";
    # hints electron aps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  system.autoUpgrade = {
    enable = true;
  };
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = { # garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

