# nixos-config
*my flkae <3*

`flake.nix` automatically detects all directories under `./host` and creates a NixOS system with the directory name as the host name for each. There are four special names under each host directory:
- `default.nix` can receive `inputs` (or not) and is fed into custom [#`mkHost`](`mkHost` function) outlined below
- `configuration.nix` is imported as a NixOS module
- `hardware-configuration.nix` is imported as a NixOS module
- `home.nix` is imported as a Home Manager module

## `mkHost`
This is a custom function designed to set defaults and automatically assume modules and configuration for every NixOS system. It takes an attribute set of attribut sets; the names are hostnames, and the nested attributes are as follows:
- `modules ? [ ]`: passed directly to `nixosSystem`; includes default module, `configuration.nix`, `hardware-configuration.nix`, and some Home Manager configuration
- `home-modules ? [ ]`: imported as shared modules in `nixosSystem`; includes default Home Manager module and `home.nix`
- `system ? "x86_64-linux"`: passed directly to `nixosSystem`
- `specialArgs ? { inherit inputs; }` passed directly to `nixosSystem`
