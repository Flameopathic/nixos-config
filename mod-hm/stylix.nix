{ inputs, lib, pkgs, ... }: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  config.stylix = {
    enable = true;
    image = lib.mkDefault ../resources/leafy-moon.png;
    base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    cursor = {
      package = pkgs.bibata-cursors-translucent;
      name = "Bibata_Ghost";
      size = 24;
    };
  };
}