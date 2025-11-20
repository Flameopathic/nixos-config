{
  pkgs,
  config,
  lib,
  ...
}:

with config.lib.stylix;
with config.stylix.fonts;
with config.lib.stylix.colors.withHashtag;
with config.boot.loader.grub;

let
  mkGrubFont =
    font: size:
    pkgs.runCommand "${font}.pf2"
      {
        font = font;
      }
      ''
        # Convert to .pf2
        ${pkgs.grub2}/bin/grub-mkfont $font --output $out --size ${size}
      '';

  round = number: builtins.floor (number + 0.5);

  # "with respect to" functions; useful for setting one value for sure and scaling another based on aspect ratio
  wrtX = number: number * dimensions.y / dimensions.x;
  wrtY = number: number * dimensions.x / dimensions.y;

  fontSize = round (dimensions.y * 45 / 1440);
in

{
  options.boot.loader.grub.dimensions = {
    x = lib.mkOption {
      description = "x dimension of the monitor which will be used on boot";
      type = lib.types.int;
      default = 1920;
    };
    y = lib.mkOption {
      description = "y dimension of the monitor which will be used on boot";
      type = lib.types.int;
      default = 1200;
    };
  };

  config.boot.loader.grub = {
    splashImage = lib.mkForce ../resources/outer-wilds/title-screen.png;
    splashMode = "normal";
    theme = lib.mkOverride 99 (
      pkgs.runCommand "outer-wilds-grub"
        {
          themeTxt = ''
            desktop-image: "background.png"
            desktop-image-scale-method: "fitwidth"

            title-text: ""

            + image {
              file = logo.png
              top = 10%
              left = ${builtins.toString (round (wrtX 10))}%
              height = 30%
              width = ${builtins.toString (round (wrtX (30 * 669 / 298)))}%
            }

            + boot_menu {
              top = 50%
              left = ${builtins.toString (round (wrtX 10))}%
              height = 40%
              width = 40%
              item_font = "ITC Serif Gothic Std Bold ${builtins.toString fontSize}"
              item_color = "#ff7d25"
              selected_item_color = "#ffffa0"
              item_height = 60
              item_padding = 0
              item_spacing = 20
              scrollbar = false
            }
          '';
          passAsFile = [ "themeTxt" ];
        }
        ''
          mkdir $out
          cp $themeTxtPath $out/theme.txt

          cp ${../resources/outer-wilds/title-screen.png} $out/background.png
          cp ${../resources/outer-wilds/logo.png} $out/logo.png

          cp ${mkGrubFont ../resources/outer-wilds/title-font.otf (builtins.toString fontSize)} $out/sans_serif.pf2
        ''
    );
  };
}
