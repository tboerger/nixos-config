{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.homedns;

in
{
  options = {
    personal = {
      services = {
        homedns = {
          enable = mkEnableOption "HomeDNS";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      adguardhome = {
        enable = true;
        mutableSettings = false;

        settings = {
          bind_host = "127.0.0.1";
          bind_port = 3000;

          dhcp = {
            enabled = false;
          };

          dns = {
            bind_host = "0.0.0.0";
            bind_port = 53;

            bootstrap_dns = [
              "1.1.1.1"
              "8.8.8.8"
            ];

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

      nginx = {
        virtualHosts =
          let
            base = locations: {
              inherit locations;

              useACMEHost = "boerger.ws";
              forceSSL = true;
            };
            proxy = port: base {
              "/" = {
                proxyPass = "http://127.0.0.1:" + toString (port) + "/";
                proxyWebsockets = true;
              };
            };
          in
          {
            "adguard.boerger.ws" = proxy 3000;
          };
      };
    };

    personal = {
      services = {
        acme = {
          enable = true;
        };

        webserver = {
          enable = true;
        };
      };
    };
  };
}
