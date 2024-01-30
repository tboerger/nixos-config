{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.gallery;

in
{
  options = {
    personal = {
      services = {
        gallery = {
          enable = mkEnableOption "Gallery";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      # photoprism = {
      #   enable = true;

      #   settings = { };
      # };

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
            "gallery.boerger.ws" = proxy 2342;
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
