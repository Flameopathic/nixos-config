let
  fnix2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC38crYgufmRowdoWdCfMZxF0uwl2xcFuNLjnN8tspUP";
in {
  "wg.age".publicKeys = [ fnix2 ];
}