{ config, lib, pkgs, nodes, ... }:
let
  global = ''
    global
      log /dev/log local0 notice

    frontend main_frontend
      bind 0.0.0.0:80
      bind 0.0.0.0:443
  '';
  
  site = { sitename, backends }: ''
    backend ${sitename}
  '' + unlines map backend backends;

  backend = {backends}: ''
    server ${backend}
  '';
in { config, pkgs, nodes, ... }: {
  services.haproxy = {
    enable = true;
    config = global + site { sitename = "foo"; backends = ["localhost"]; };
  };
}
