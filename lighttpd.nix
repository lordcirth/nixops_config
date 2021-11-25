{ config, pkgs, nodes, ... }: {
  services.lighttpd = {
    enable = true;
    # document-root = fetchGit {};
  };
}
