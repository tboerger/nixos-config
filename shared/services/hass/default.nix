{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.hass;

in
{
  options = {
    personal = {
      services = {
        hass = {
          enable = mkEnableOption "Home Assistant";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        sqlite
      ];
    };

    services = {
      home-assistant = {
        enable = true;

        package = (pkgs.home-assistant.override {
          extraPackages = python3Packages: with python3Packages; [
            pyicloud
            radios
            securetar
          ];

          extraComponents = [
            "accuweather"
            "adguard"
            "alexa"
            "default_config"
          ];
        }).overrideAttrs (oldAttrs: {
          doInstallCheck = false;
        });

        config = {
          http = {
            server_host = "127.0.0.1";
            server_port = 8123;
            trusted_proxies = [ "127.0.0.1" ];
            use_x_forwarded_for = true;
          };

          homeassistant = {
            name = "Boerger";
            latitude = 49.406330;
            longitude = 11.036830;
            time_zone = "Europe/Berlin";
            unit_system = "metric";
            temperature_unit = "C";
          };

          default_config = { };
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
            "iot.boerger.ws" = proxy 8123;
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
