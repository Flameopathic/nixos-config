{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
    extensions = [
      "nix"
    ];
    userSettings = {
      lsp.nil.settings = {
        formatting.command = [
          "nixfmt"
          "-w=80"
        ];
        diagnostics.suppress = [ ];
      };
      languages.Nix.language_servers = [
        "nil"
        "!nixd"
      ];

      disable_ai = true;
    };
  };
}
