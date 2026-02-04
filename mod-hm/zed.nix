{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.nil # python language server
    pkgs.unstable.nixfmt

    pkgs.ruff # python language server
  ];
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor; # necessary for signing in
    extensions = [
      "nix"
      "rust"
      "live-server"
    ];
    userSettings = {
      use_system_path_prompts = false;
      lsp = {
        nil.settings = {
          nix = {
            maxMemoryMB = 6120;
            flake = {
              autoArchive = true;
              autoEvalInputs = true;
            };
          };
          formatting.command = [
            "nixfmt"
            "-w=80"
          ];
          diagnostics.suppress = [ ];
        };
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.unstable.rust-analyzer;
          };
          initialization_options = {
            inlayHints = {
              maxLength = 140;
              lifetimeElisionHints = {
                enable = "skip_trivial";
                useParameterNames = true;
              };
              closureReturnTypeHints = {
                enable = "always";
              };
            };
          };
        };
      };
      languages.Nix = {
        tab_size = 2;
        language_servers = [
          "nil"
          "!nixd"
        ];
      };

      disable_ai = true;
    };
  };
}
