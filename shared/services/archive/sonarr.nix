{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        exportarr-sonarr = {
          enable = true;
        };
      };
    };

    sonarr = {
      enable = true;
      user = "media";
      group = "users";
      dataDir = "/var/lib/sonarr";
    };
  };
}
