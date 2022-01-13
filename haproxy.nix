{ sites }:
{ config, lib, pkgs, nodes, ... }:
let
  unlines = lib.concatStringsSep "\n";

  global = ''
    global
      log /dev/log local0 notice

    defaults
      timeout connect 10000
      timeout check 10000
      timeout client 30000
      timeout server 30000

    frontend main_frontend
      bind 0.0.0.0:80
      bind 0.0.0.0:443


  '';

  stats = ''
    listen stats
      bind 0.0.0.0:1936
      mode http
      log global

      stats enable
      stats hide-version
      stats refresh 30s
      stats show-node
      stats uri /

  '';

  site = { sitename, backend_servers }:
    ''
      backend ${sitename}
    '' + unlines (map (backend) backend_servers);

  backend = server: "  server ${server} ${server}:80 check";

in {
  networking.firewall.allowedTCPPorts = [ 80 443 1936 ];
  boot.kernel.sysctl = { "net.ipv4.ip_nonlocal_bind" = true; };

  services.haproxy = {
    enable = true;
    config = global + stats + unlines (map (site) sites);
  };
}
