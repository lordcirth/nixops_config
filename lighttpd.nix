{ config, pkgs, nodes, ... }: {
  services.lighttpd = let
    datadir = fetchTarball {
      url = "http://www.catb.org/jargon/jargon-4.4.7.tar.gz";
      sha256 = "0vfk4908lhgzbqgz3n4km05wnr6y5v52i1ipybrsa93069yiwdi7";
    };
  in {
    enable = true;
    document-root = "${datadir}/html";
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
