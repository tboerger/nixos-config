{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        exportarr-bazarr = {
          enable = true;
        };
      };
    };

    bazarr = {
      enable = true;
      user = "media";
      group = "users";
    };
  };
}
