{ config, pkgs, nodes, ... }: let {
  global = ''
    global
    log /dev/log local0 notice
  ''
} in {
  services.haproxy = {
    enable = true;
    config = global;
  };
}
