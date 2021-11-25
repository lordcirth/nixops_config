{ config, pkgs, nodes, ... }: {
  services.lighttpd = {
    enable = true;
    # document-root = fetchGit {};
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
