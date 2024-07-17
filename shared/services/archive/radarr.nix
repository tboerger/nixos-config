{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        exportarr-radarr = {
          enable = true;
        };
      };
    };

    radarr = {
      enable = true;
      user = "media";
      group = "users";
      dataDir = "/var/lib/radarr";
    };
  };
}
