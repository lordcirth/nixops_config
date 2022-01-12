{ config, lib, pkgs, nodes, ... }:
let
  unlines = lib.concatStringsSep "\n";

  global = ''
    global
      log /dev/log local0 notice

      timeout connect 10000
      timeout check 10000
      timeout client 30000
      timeout server 30000

    frontend main_frontend
      bind 0.0.0.0:80
      bind 0.0.0.0:443
  '';
  
  site = { sitename, backend_servers }: ''
    backend ${sitename}
  '' + unlines (map (backend) backend_servers);

  backend = server: ''
    server ${server} ${server}:443
  '';
in {
  services.haproxy = {
    enable = true;
    config = global + site { sitename = "foo"; backend_servers = ["localhost"]; };
  };
}
