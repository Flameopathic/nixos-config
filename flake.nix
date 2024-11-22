{
  description = "my flkae <3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:Flameopathic/home-manager/release-24.05"; # TODO: change back once vesktop module is merged
      inputs.nixpkgs.follows = "nixpkgs"; # ensures nixpkgs version is consistent between home manager and system
    };
    nix-darwin = {
      # declarative macOS with nix
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      # secure boot
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      # declarative disks
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      # makes remote servers work
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:Misterio77/nix-colors";
    stylix = {
      url = "github:danth/stylix/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    with inputs;
    {
      nixosConfigurations =
        let
          mkHost =
            host:
            {
              modules ? [ ],
              home-modules ? [ ],
              system ? "x86_64-linux",
              specialArgs ? {
                inherit inputs;
              },
              ...
            }:
            nixpkgs.lib.nixosSystem {
              system = system;
              modules =
                modules
                ++ [
                  (
                    { ... }:
                    {
                      networking.hostName = host;
                    }
                  )
                  ./mod
                  home-manager.nixosModules.home-manager
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = false;
                      extraSpecialArgs = {
                        inherit inputs;
                      };
                      backupFileExtension = "hm-bkp";
                      users.flame = {
                        imports =
                          home-modules
                          ++ [ ./mod-hm ]
                          ++ nixpkgs.lib.optional (builtins.pathExists ./host/${host}/home.nix) ./host/${host}/home.nix;
                      };
                    };
                  }
                ]
                ++ nixpkgs.lib.optional (builtins.pathExists ./host/${host}/hardware-configuration.nix) ./host/${host}/hardware-configuration.nix
                ++ nixpkgs.lib.optional (builtins.pathExists ./host/${host}/configuration.nix) ./host/${host}/configuration.nix;
              specialArgs = specialArgs;
            };

        in
        builtins.mapAttrs mkHost {
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
              {
                flame.hyprland.monitor = [
                  "Unknown-1, disabled"
                  "DP-1, highres, 0x0, auto"
                  "HDMI-A-1, highres, 3200x1440, 1"
                ];
              }
              ./mod-hm/ui-apps.nix
              ./mod-hm/rose-pine.nix
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
              {
                flame.hyprland.monitor = [
                  "eDP-1, preferred, 1920x0, auto"
                  "DP-1, preferred, 0x0, 1"
                ];
              }
              ./mod-hm/ui-apps.nix
              ./mod-hm/rose-pine.nix
            ];
          };
          servnix = {
            system = "aarch64-linux";
            modules = [
              ./mod/rpi-boot.nix
              ./mod/ssh-server.nix
              ./mod/syncthing.nix
              { flame.syncthing.server = true; }
            ];
          };
          shaktop = {
            modules = [
              ./mod/sd-boot.nix
              ./mod/mc-server.nix
              ./mod/laptop-server.nix
              ./mod/ssh-server.nix
              ./mod/unturned.nix
              { flame.ssh-server.openFirewall = true; }
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
      darwinConfigurations =
        let
          mkDarwin =
            host:
            {
              modules ? [ ],
              home-modules ? [ ],
              system ? "x86_64-darwin",
              specialArgs ? {
                inherit inputs;
              },
              ...
            }:
            nix-darwin.lib.darwinSystem {
              modules = modules ++ [
                (
                  { ... }:
                  {
                    networking.hostName = host;
                    nixpkgs.hostPlatform = system;
                  }
                )
                ./host/${host}/configuration.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = {
                      inherit inputs;
                    };
                    users.flame = {
                      imports = home-modules ++ [ ./mod-hm ];
                    };
                  };
                }
              ];
              specialArgs = specialArgs;
            };
        in
        builtins.mapAttrs mkDarwin { bear = { }; };
    };
}
