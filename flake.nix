{
  description = "my flkae <3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, lanzaboote, ... }@inputs: {
    # make configuration name same as host name to make rebuild command work automagically
    nixosConfigurations = {
      fnix2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # makes it so that all submodules can use inputs
        modules = [ # nixos imports
          ./host/fnix2/configuration.nix
          ./mod/default.nix
          home-manager.nixosModules.home-manager {
      	    home-manager = {
              useGlobalPkgs = true;
        	    useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
        	    users.flame = {
                imports = [ # home-manager imports
                  ./host/fnix2/home.nix
                  ./mod-hm/default.nix
                ];
              };
            };
      	  }
        ];
      };
      surfnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/surfnix/configuration.nix
          ./mod/default.nix
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.flame = {
                imports = [
                  ./host/surfnix/home.nix
                  ./mod-hm/default.nix
                ];
              };
            };
          }
        ];
      };
      servnix = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/servnix/configuration.nix
          ./prof/nixos/default.nix
          ./prof/nixos/mc-server.nix
          ./prof/nixos/rpi-boot.nix
          ./prof/nixos/rpi4-overclock.nix
          ./prof/nixos/ssh-server.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.flame = {
                imports = [
                  ./prof/h-m/flame.nix
                ];
              };
            };
          }
        ];
      };
      shaktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/shaktop/configuration.nix
          ./prof/nixos/default.nix
          ./prof/nixos/mc-server.nix
          ./prof/nixos/sd-boot.nix
          ./prof/nixos/ssh-server.nix
          ./prof/nixos/remote-ssh.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.flame = {
                imports = [
                  ./prof/h-m/flame.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
