let
  global = ''
    global
    log /dev/log local0 notice
  '';
in { config, pkgs, nodes, ... }: {
  services.haproxy = {
    enable = true;
    config = global;
  };
}
