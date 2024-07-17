{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.cloud;
  hostAddress = "192.168.100.10";
  containerAddress = "192.168.100.11";

in
{
  options = {
    personal = {
      services = {
        cloud = {
          enable = mkEnableOption "Cloud";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    system = {
      activationScripts = {
        makeCloudDir = lib.stringAfter [ "var" ] ''
          mkdir -p /var/lib/nextcloud/{server,postgres,redis,backups}
        '';
      };
    };

    containers = {
      cloud = {
        autoStart = true;
        privateNetwork = true;
        ephemeral = true;

        hostAddress = hostAddress;
        localAddress = containerAddress;

        bindMounts = {
          "/var/lib/nextcloud" = {
            hostPath = "/var/lib/nextcloud-server";
            isReadOnly = false;
          };
          "/var/lib/postgresql" = {
            hostPath = "/var/lib/nextcloud-postgres";
            isReadOnly = false;
          };
          "/var/lib/redis-nextcloud" = {
            hostPath = "/var/lib/nextcloud-redis";
            isReadOnly = false;
          };
          "/var/backups" = {
            hostPath = "/var/lib/nextcloud-backups";
            isReadOnly = false;
          };

          "${config.age.secrets."services/cloud/password".path}" = {
            isReadOnly = true;
          };
        };

        config = { config, pkgs, ... }: {
          system = {
            stateVersion = "23.11";
          };

          imports = [
            ./networking.nix
            ./tmpfiles.nix
            ./postgres.nix
            ./redis.nix
            ./nextcloud.nix
          ];
        };
      };
    };

    personal = {
      services = {
        webserver = {
          enable = true;

          hosts = [
            {
              domain = "cloud.boerger.ws";
              proxy = "http://${containerAddress}:80";
            }
          ];
        };
      };
    };

    age.secrets."services/cloud/password" = {
      file = ../../../secrets/services/cloud/password.age;
      owner = "999";
      group = "999";
    };
  };
}
