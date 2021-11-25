{
  description = "NixOps 2.0 test flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixops.url = "github:nixos/nixops";
  };

  outputs = { self, nixpkgs, nixops }: {
    nixopsConfigurations.default = {
        nixpkgs = nixpkgs;
      network = {
        enableRollback = true;
      };

      defaults = {
        deployment.targetHost = "localhost";
        deployment.targetEnv  = "libvirt";
      };
      vm1 = {};
    };
  };
}
