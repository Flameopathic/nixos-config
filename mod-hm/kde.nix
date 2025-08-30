{ inputs, ... }:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
  programs.plasma = {
    enable = true;
    overrideConfig = true;
    hotkeys.commands = {
      toggle-theme = {
        command = "toggle-theme";
        key = "Meta+T";
      };
      terminal = {
        command = "foot";
        key = "Meta+Return";
      };
    };
    input.touchpads = [
      {
        name = "SYNA2BA6:00 06CB:CFD8 Touchpad";
        vendorId = "06CB";
        productId = "CFD8"; 
        enable = true;
        disableWhileTyping = true;
        leftHanded = true;
        middleButtonEmulation = true;
        naturalScroll = true;
        tapToClick = true;
        pointerSpeed = 0;
      }
    ];
    panels = [
      {
        location = "bottom";
        alignment = "left";
        floating = true;
        height = 44;
        hiding = "dodgewindows";
        screen = "all";
      }
    ];
  };
}
