{
  description = "my flkae <3";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:Flameopathic/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # ensures nixpkgs version is consistent between home manager and system
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs: {
    nixosConfigurations = let 
      mkHost = host: { modules ? [], home-modules ? [], system ? "x86_64-linux", specialArgs ? { inherit inputs; }, ... }: inputs.nixpkgs.lib.nixosSystem {
        system = system;
        modules = modules ++ [
          ({ ... }: {
            networking.hostName = host;
          })
          ./host/${host}/configuration.nix
          ./mod
          inputs.home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.flame = {
                imports = home-modules ++ [
                  ./host/${host}/home.nix
                  ./mod-hm
                ];
              };
            };
          }
        ];
        specialArgs = specialArgs;
      };

    in builtins.mapAttrs mkHost {
      # make configuration name same as host name to make rebuild command work automagically
      # system default is "x86_64-linux"
      # modules default to ./mod and ./host/${host}/configuration.nix
      # specialArgs defaults to inheriting inputs alone
      fnix2 = {
        modules = [
          ./mod/sd-boot.nix
          ./mod/ui.nix
          ./mod/hyprland.nix
          ./mod/nvidia.nix
          ./mod/remote-builder.nix
          ./mod/ssh-server.nix
          ./mod/syncthing.nix
        ];
        home-modules = [
          ./mod-hm/hyprland.nix {
            flame.hyprland.monitor = [ "Unknown-1, disabled" "DP-1, highres, auto, auto" ];
          }
          ./mod-hm/ui-apps.nix
        ];
      };
      surfnix = {
        modules = [
          ./mod/sd-boot.nix
          ./mod/ui.nix
          ./mod/hyprland.nix
          ./mod/surface.nix
          ./mod/syncthing.nix
        ];
        home-modules = [
          ./mod-hm/hyprland.nix
          ./mod-hm/ui-apps.nix
        ];
      };
      servnix = {
        system = "aarch64-linux";
        modules = [
          ./mod/rpi-boot.nix
          ./mod/ssh-server.nix
          ./mod/syncthing.nix {
            flame.syncthing.server = true;
          }
        ];
      };
      shaktop = {
        modules = [
          ./mod/sd-boot.nix
          ./mod/mc-server.nix
          ./mod/ssh-server.nix {
            flame.ssh-server.openFirewall = true;
          }
        ];
      };
    };
  };
}
