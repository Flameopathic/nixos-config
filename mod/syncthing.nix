{ config, lib, ... }:

with lib;

let
  cfg = config.flame.syncthing;
in
{
  options.flame.syncthing = {
    server = mkEnableOption "syncthing server (with open ports)";
    home = mkOption {
      description = "home folder";
      default = "/home/flame";
    };
    devices = mkOption {
      description = "devices to share all folders with";
      default = [
        "fnix2"
        "surfnix"
        "servnix"
      ];
    };
  };

  config.services.syncthing = {
    enable = true;
    openDefaultPorts = cfg.server;
    user = mkDefault "flame";
    dataDir = mkDefault "${cfg.home}/.config/syncthing";
    overrideDevices = mkDefault true;
    overrideFolders = mkDefault true;
    settings = {
      devices = {
        "fnix2" = {
          id = "GGVWVIS-UBTT7HL-DS3RF56-JGLVBZ6-KXD4JJG-J2WB7AR-7AY5V32-VW3FSQW";
        };
        "surfnix" = {
          id = "NGSXK5O-5B2CGLJ-TAHOSKL-B4L5Y52-TFSPK3Y-3L6XGVD-YBUPIAF-7SVROA6";
        };
        "servnix" = {
          id = "7UIBIOJ-LARMQXE-HEZH52U-NKB3J6T-W3SCKGH-SHPV5OY-B3KXSSB-UTOMQQC";
        };
        "tomato" = {
          id = "NJUAEBY-NXMNGIF-JN2OTKH-MXGEKJ5-R2MJEMI-5P4J2JO-HLDK4O4-4JSFDAG";
        };
      };
      folders = {
        doc = {
          path = "${cfg.home}/doc";
          devices = cfg.devices ++ [ "tomato" ];
          id = "doc";
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "0";
          };
        };
        pic = {
          path = "${cfg.home}/pic";
          devices = cfg.devices;
          id = "pic";
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "0"; # never clean out - prolly a bad idea, but the versioning system isn't hugely good anyway
          };
        };
        prg = {
          path = "${cfg.home}/prg";
          devices = cfg.devices;
          id = "prg";
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "0";
          };
        };
        phone = {
          path = "${cfg.home}/pic/phone";
          devices = cfg.devices ++ [
            "tomato"
          ];
        };
        mus = {
          path = "${cfg.home}/mus";
          devices = cfg.devices ++ [
            "tomato"
          ];
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "0";
          };
        };
        arc = {
          path = "${cfg.home}/arc";
          devices = cfg.devices;
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "0";
          };
        };
      };
      options = {
        urAccepted = -1;
      };
    };
  };
}
