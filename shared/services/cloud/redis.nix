{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        redis = {
          enable = true;
          openFirewall = true;
        };
      };
    };

    redis = {
      vmOverCommit = true;

      servers = {
        nextcloud = {
          port = 6379;
        };
      };
    };
  };
}
