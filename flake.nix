{
  description = "my flkae <3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    dolphin-overlay.url = "github:rumboon/dolphin-overlay";

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # theming
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-discord-theme = {
      url = "github:rose-pine/discord";
      flake = false;
    };
    rose-pine-wallpapers = {
      url = "github:rose-pine/wallpapers";
      flake = false;
    };
    hide-elements-vesktop-theme = {
      url = "https://gist.githubusercontent.com/Katzenwerfer/e9cc02cf5743c879cd431e3839947665/raw/398be790fc0485b8d133f0dec201f619378bb8b6/discord-cleaner.css";
      flake = false;
    };
  };

  outputs =
    { ... }@inputs:
    with inputs;
    {
      nixosConfigurations =
        let
          detectHosts = (
            nixpkgs.lib.mapAttrs (
              host: kind:
              nixpkgs.lib.optionalAttrs (kind == "directory") (
                let
                  module = import ./host/${host};
                in
                if nixpkgs.lib.isFunction module then module { inherit inputs; } else module
              )
            ) (builtins.readDir ./host)
          );
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
        builtins.mapAttrs mkHost detectHosts;
      # make configuration name same as host name to make rebuild command work automagically
      # system default is "x86_64-linux"
      # modules default to ./mod and ./host/${host}/configuration.nix
      # specialArgs defaults to inheriting inputs alone
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
