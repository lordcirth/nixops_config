{ config, pkgs, nodes, ... }: {
  services.cockroachdb = {
  enable = true;
  join = [ nodes.cdb1.name ];
};
