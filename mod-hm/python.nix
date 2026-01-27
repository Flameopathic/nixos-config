{ pkgs, lib, ... }:
lib.mkMerge [
  {
    home.packages = with pkgs; [
      ruff
    ];
  }
  {
    home.packages = with pkgs.python313Packages; [
      pip
      pillow
    ];
  }
]
