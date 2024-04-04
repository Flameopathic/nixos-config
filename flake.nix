{
  description = "my flkae <3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs"; # ensures nixpkgs version is consistent between home manager and system
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # make configuration name same as host name to make rebuild command work automagically
    nixosConfigurations = {
      fnix2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # makes it so that all submodules can use inputs
        modules = [
          ./host/fnix2/configuration.nix
          ./prof/nixos/default.nix
          ./prof/nixos/sd-boot.nix
          ./prof/nixos/ui.nix          
          ./prof/nixos/nvidia.nix
          home-manager.nixosModules.home-manager {
      	    home-manager.useGlobalPkgs = true;
      	    home-manager.useUserPackages = true;
      	    home-manager.users.flame = {
              imports = [
                ./prof/h-m/flame.nix
                # other modules
                ./prof/h-m/hyprland.nix
              ];
            };
      	  }
        ];
      };
      surfnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/surfnix/configuration.nix
          ./prof/nixos/default.nix
          ./prof/nixos/sd-boot.nix
          ./prof/nixos/ui.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.flame = {
              imports = [
                ./prof/h-m/flame.nix
                ./prof/h-m/hyprland.nix
              ];
            };
          }
        ];
      };
    };
  };
}
