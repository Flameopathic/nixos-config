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
      default = [ "fnix2" "surfnix" "servnix" ];
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
          id = "ONYBVSG-TRXS6VT-CXQ737X-CD4QQ5B-PQEJIC6-23CORFG-RA3MGDZ-X6YYBQP";
        };
        "surfnix" = {
          id = "NJRGKSE-QTLVGI6-KUIMKVT-53GP7IN-6XUTFMZ-KKG76DZ-45Q6K2Q-P6AAIAB";
        };
        "servnix" = {
          id = "DGMX5KZ-AUI3E4J-DHOPIFF-YRCOMWK-WZ6PUX3-2UHDTVH-RDTMFO3-ZP6M5QM";
        };
        "foldeopathic" = {
          id = "5GC5N6H-LHNYSOH-LXBY746-U3OEOXH-LVKQFDD-P2QTFB2-6HTAOHY-Y6I4CAO";
        };
      };
      folders = {
        doc = {
          path = "${cfg.home}/doc";
          devices = cfg.devices;
          id = "doc";
          versioning = {
            type = "trashcan";
            params.cleanoutDays = "1000";
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
            params.cleanoutDays = "1000";
          };
        };
        phone = {
          path = "${cfg.home}/pic/phone";
          devices = cfg.devices ++ [ "foldeopathic" ];
        };
        mus = {
          path = "${cfg.home}/mus";
          devices = cfg.devices ++ [ "foldeopathic" ];
        };
      };
      options = {
        urAccepted = -1;
      };
    };
  };
}
