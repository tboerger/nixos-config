{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.adguard;

in
{
  options = {
    personal = {
      services = {
        adguard = {
          enable = mkEnableOption "Adguard";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      adguardhome = {
        enable = true;
        mutableSettings = false;

        host = "127.0.0.1";
        port = 3000;

        settings = {
          dns = {
            port = 5353;
            bind_host = "127.0.0.1";
            bootstrap_dns = "1.1.1.1";

            upstream_dns = [
              "1.1.1.1"
              "8.8.8.8"
            ];
          };

          users = [{
            name = "admin";
            password = "$2y$05$wzuDDF0NaP0zX.gguP8EyuBJ1wlyTPjLvXf.LCK8VCBKIUq4PnR62";
          }];
        };
      };
    };

    personal = {
      services = {
        webserver = {
          enable = true;

          hosts = [
            {
              domain = "adguard.boerger.ws";
              proxy = "http://localhost:3000";
            }
          ];
        };
      };
    };
  };
}
