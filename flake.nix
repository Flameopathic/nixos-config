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

  outputs = { nixpkgs, nixos-hardware, ... }@inputs: {
    nixosConfigurations = let 
      mkHost = host: { modules ? [], system ? "x86_64-linux", specialArgs ? { inherit inputs; }, ... }: nixpkgs.lib.nixosSystem {
        system = system;
        modules = modules ++ [
          ({ ... }: {
            networking.hostName = host;
          })
          ./host/${host}/configuration.nix
          ./mod
        ];
        specialArgs = specialArgs;
      };

    in builtins.mapAttrs mkHost {
      # make configuration name same as host name to make rebuild command work automagically
      # system default is "x86_64-linux"
      # modules default to ./mod and ./host/${host}/configuration.nix
      # specialArgs defaults to inheriting inputs alone
      fnix2 = {
        modules = [];
      };
      surfnix = {
        modules = [ nixos-hardware.nixosModules.microsoft-surface-pro-intel ];
      };
      servnix = {
        system = "aarch64-linux";
      };
      shaktop = {
        modules = [];
      };
    };
  };
}
