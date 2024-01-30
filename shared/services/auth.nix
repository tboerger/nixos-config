{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.auth;

in
{
  options = {
    personal = {
      services = {
        auth = {
          enable = mkEnableOption "Auth";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {

      # TDB

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
            "auth.boerger.ws" = proxy 2342;
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
