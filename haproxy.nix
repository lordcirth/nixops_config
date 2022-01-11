{ config, lib, pkgs, nodes, ... }:
let
  unlines = lib.concatStringsSep "\n";

  global = ''
    global
      log /dev/log local0 notice

    frontend main_frontend
      bind 0.0.0.0:80
      bind 0.0.0.0:443
  '';
  
  site = { sitename, backend_servers }: ''
    backend ${sitename}
  '' + unlines (map (backend) backend_servers);

  backend = server: ''
    server ${server}
  '';
in {
  services.haproxy = {
    enable = true;
    config = global + site { sitename = "foo"; backend_servers = ["localhost"]; };
  };
}
