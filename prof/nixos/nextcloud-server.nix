{ config, inputs, pkgs }: {
  # TODO: admin password
  
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud28;
    maxUploadSize = "500G";
    hostName = "drive.flameopathic.com";
  };
}