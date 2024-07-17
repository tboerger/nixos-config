{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        exportarr-prowlarr = {
          enable = true;
        };
      };
    };

    prowlarr = {
      enable = true;
      user = "media";
      group = "users";
      dataDir = "/var/lib/prowlarr";
    };
  };
}
