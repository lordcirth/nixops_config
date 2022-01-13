{
  description = "NixOps 2.0 test flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixops.url = "github:nixos/nixops";
  };

  outputs = { self, nixpkgs, nixops }:
    let
      haproxy = s:
        (import ./haproxy.nix {
          sites = [ s ];
          floating_ip = "192.168.122.10";
        });
    in {
      nixopsConfigurations.default = {
        nixpkgs = nixpkgs;
        network = { enableRollback = true; };

        defaults = {
          deployment.targetHost = "localhost";
          deployment.targetEnv = "libvirtd";
          imports = [ ./common.nix ];
        };
        web1 = import ./lighttpd.nix;
        web2 = import ./lighttpd.nix;
        haproxy1 = haproxy {
          sitename = "jargon";
          backend_servers = [ "web1" "web2" ];
        };
      };
    };
}
