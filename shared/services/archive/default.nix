{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.archive;
  hostAddress = "192.168.100.30";
  containerAddress = "192.168.100.31";

in
{
  options = {
    personal = {
      services = {
        archive = {
          enable = mkEnableOption "Archive";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    system = {
      activationScripts = {
        makeArchiveDir = lib.stringAfter [ "var" ] ''
          mkdir -p /var/lib/nextcloud/{server,postgres,redis,backups}
        '';
      };
    };

    containers = {
      archive = {
        autoStart = true;
        privateNetwork = true;
        ephemeral = true;

        hostAddress = hostAddress;
        localAddress = localAddress;

        bindMounts = {



          "/var/lib/sabnzbd" = {
            hostPath = "/var/lib/sabnzbd";
            isReadOnly = false;
          };
          "/var/lib/radarr" = {
            hostPath = "/var/lib/radarr";
            isReadOnly = false;
          };
          "/var/lib/sonarr" = {
            hostPath = "/var/lib/sonarr";
            isReadOnly = false;
          };
          "/var/lib/lidarr" = {
            hostPath = "/var/lib/lidarr";
            isReadOnly = false;
          };
          "/var/lib/prowlarr" = {
            hostPath = "/var/lib/prowlarr";
            isReadOnly = false;
          };
          "/var/lib/bazarr" = {
            hostPath = "/var/lib/bazarr";
            isReadOnly = false;
          };
          "/var/lib/filebrowser" = {
            hostPath = "/var/lib/filebrowser";
            isReadOnly = false;
          };
          "/var/lib/music" = {
            hostPath = "/var/lib/music";
            isReadOnly = false;
          };



        };

        config = { config, pkgs, ... }: {
          system = {
            stateVersion = "23.11";
          };

          imports = [
            ./networking.nix
            ./tmpfiles.nix
            ./jellyfin.nix
            ./jellyseer.nix
            ./sabnzbd.nix
            ./radarr.nix
            ./sonarr.nix
            ./lidarr.nix
            ./prowlarr.nix
            ./bazarr.nix
            ./filebrowser.nix
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
              domain = "request.boerger.ws";
              proxy = "http://${containerAddress}:5055";
            }
            {
              domain = "jellyfin.boerger.ws";
              proxy = "http://${containerAddress}:8096";
            }
            {
              domain = "sabnzbd.boerger.ws";
              proxy = "http://${containerAddress}:8080";
            }
            {
              domain = "radarr.boerger.ws";
              proxy = "http://${containerAddress}:7878";
            }
            {
              domain = "sonarr.boerger.ws";
              proxy = "http://${containerAddress}:8989";
            }
            {
              domain = "lidarr.boerger.ws";
              proxy = "http://${containerAddress}:8686";
            }
            {
              domain = "bazarr.boerger.ws";
              proxy = "http://${containerAddress}:6767";
            }
            {
              domain = "prowlarr.boerger.ws";
              proxy = "http://${containerAddress}:9696";
            }
            {
              domain = "music.boerger.ws";
              proxy = "http://${containerAddress}:8080";
            }
          ];
        };
      };
    };
  };
}
