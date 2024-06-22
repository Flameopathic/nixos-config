{ ... }:{
  imports = [
    ./battery.nix
  ];

  config.security.pki.certificateFiles = [ ../resources/enterprise.pem ];
}
