{
  description = "my flkae <3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:Flameopathic/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs"; # ensures nixpkgs version is consistent between home manager and system
    };
    nix-darwin = { # declarative macOS with nix
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = { # secure boot
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = { # declarative disks
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = { # makes remote servers work
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:Misterio77/nix-colors";
  };

  outputs = { ... }@inputs: with inputs; {
    nixosConfigurations = let 
      mkHost = host: { modules ? [], home-modules ? [], system ? "x86_64-linux", specialArgs ? { inherit inputs; }, ... }: nixpkgs.lib.nixosSystem {
        system = system;
        modules = modules ++ [
          ({ ... }: {
            networking.hostName = host;
          })
          ./host/${host}/configuration.nix
          ./host/${host}/hardware-configuration.nix
          ./mod
          home-manager.nixosModules.home-manager 
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              extraSpecialArgs = { inherit inputs; };
              users.flame = {
                imports = home-modules ++ [
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
          ./mod-hm/hyprland.nix
          {
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
          {
            flame.hyprland.monitor = [ "eDP-1, preferred, 1920x0, auto" "DP-1, preferred, 0x0, 1" ];
          }
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
          ./mod/laptop-server.nix
          ./mod/ssh-server.nix {
            flame.ssh-server.openFirewall = true;
          }
        ];
      };
      acervnix = {
        modules = [
          disko.nixosModules.disko
          ./host/acervnix/disk-config.nix
          ./mod/sd-boot.nix
          ./mod/ssh-server.nix
          ./mod/laptop-server.nix
        ];
      };
    };
    darwinConfigurations = let 
      mkDarwin = host: { modules ? [], home-modules ? [], system ? "x86_64-darwin", specialArgs ? { inherit inputs; }, ... }: nix-darwin.lib.darwinSystem {
        modules = modules ++ [
          ({ ... }: {
            networking.hostName = host;
            nixpkgs.hostPlatform = system;
          })
          ./host/${host}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.flame = {
                imports = home-modules ++ [
                  ./mod-hm
                ];
              };
            };
          }
        ];
        specialArgs = specialArgs;
      };
    in builtins.mapAttrs mkDarwin {
      bear = {};
    };
  };
}
