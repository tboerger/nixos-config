{ pkgs, lib, config, options, ... }:
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

          domain = mkOption {
            description = ''
              Domain used for media vhosts
            '';
            type = types.str;
            default = "boerger.ws";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    users = {
      users = {
        media = {
          group = "media";
          home = "/var/lib/media";
          uid = 20000;
          isSystemUser = true;
        };
      };

      groups = {
        media = {
          gid = 20000;
        };
      };
    };

    services = {
      nzbget = {
        enable = true;
        user = "media";
        group = "media";

        settings = {
          MainDir = "/var/lib/media/downloads";
          DestDir = "/var/lib/media/downloads/completed";
          InterDir = "/var/lib/media/downloads/intermediate";
          NzbDir = "/var/lib/media/downloads/nzb";
          QueueDir = "/var/lib/media/downloads/queue";
          TempDir = "/var/lib/media/downloads/temp";
          ScriptDir = "/var/lib/media/downloads/scripts";

          "Category1.Name" = "Movies";
          "Category1.Unpack" = "yes";

          "Category2.Name" = "Series";
          "Category2.Unpack" = "yes";

          "Category3.Name" = "Music";
          "Category3.Unpack" = "yes";

          "Category4.Name" = "Books";
          "Category4.Unpack" = "yes";

          "Category5.Name" = "Prowlarr";
          "Category5.Unpack" = "yes";
        };
      };

      jellyfin = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.jellyfin;
      };

      unpackerr = {
        enable = true;
        user = "media";
        group = "media";
        # package = pkgs.unpackerr;
      };

      radarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.radarr;
      };

      sonarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.sonarr;
      };

      lidarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.lidarr;
      };

      bazarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.bazarr;
      };

      prowlarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.prowlarr;
      };

      readarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.nur.repos.tboerger.readarr;
      };
    };

    personal = {
      services = {
        webserver = {
          enable = true;

          hosts = [
            {
              domain = "nzbget.${cfg.domain}";
              proxy = "http://localhost:6789";
            }
            {
              domain = "jellyfin.${cfg.domain}";
              proxy = "http://localhost:8096";
            }
            {
              domain = "radarr.${cfg.domain}";
              proxy = "http://localhost:7878";
            }
            {
              domain = "sonarr.${cfg.domain}";
              proxy = "http://localhost:8989";
            }
            {
              domain = "lidarr.${cfg.domain}";
              proxy = "http://localhost:8686";
            }
            {
              domain = "readarr.${cfg.domain}";
              proxy = "http://localhost:8787";
            }
            {
              domain = "bazarr.${cfg.domain}";
              proxy = "http://localhost:6767";
            }
            {
              domain = "prowlarr.${cfg.domain}";
              proxy = "http://localhost:9696";
            }
          ];
        };
      };
    };

    networking = {
      firewall = {
        allowedTCPPorts = [ 8096 ];
        allowedUDPPorts = [ 1900 7359 ];
      };
    };
  };
}
