{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        exportarr-lidarr = {
          enable = true;
        };
      };
    };

    lidarr = {
      enable = true;
      user = "media";
      group = "users";
      dataDir = "/var/lib/lidarr";
    };
  };
}
