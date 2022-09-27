{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.proxy;

in
{
  options = {
    personal = {
      services = {
        proxy = {
          enable = mkEnableOption "Proxy";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      frpc = {
        enable = true;
      };
    };
  };
}
