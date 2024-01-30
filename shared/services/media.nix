{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.media;

in
{
  options = {
    personal = {
      services = {
        media = {
          enable = mkEnableOption "Media";
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
            "sabnzbd.boerger.ws" = proxy 2342;
            "jellyfin.boerger.ws" = proxy 2342;
            "request.boerger.ws" = proxy 2342;
            "sonarr.boerger.ws" = proxy 2342;
            "radarr.boerger.ws" = proxy 2342;
            "prowlarr.boerger.ws" = proxy 2342;
            "lidarr.boerger.ws" = proxy 2342;
            "bazarr.boerger.ws" = proxy 2342;
            "music.boerger.ws" = proxy 2342;
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
