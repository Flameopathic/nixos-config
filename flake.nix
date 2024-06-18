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

  outputs = { nixpkgs, nixos-hardware, ... }@inputs: with nixpkgs.lib; {
    # make configuration name same as host name to make rebuild command work automagically
    nixosConfigurations = {
      fnix2 = nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # makes it so that all submodules can use inputs
        modules = [ # nixos imports
          ./host/fnix2/configuration.nix
          ./mod/default.nix
        ];
      };
      surfnix = nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/surfnix/configuration.nix
          ./mod/default.nix
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
        ];
      };
      servnix = nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/servnix/configuration.nix
          ./mod/default.nix
        ];
      };
      shaktop = nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/shaktop/configuration.nix
          ./mod/default.nix
        ];
      };
    };
  };
}
