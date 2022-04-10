{ pkgs, lib, config, options, ... }:

let
  cfg = config.personal.services.media;

in
{
  options = with lib; {
    personal = {
      services = {
        media = {
          enable = mkEnableOption "Media";

          domain = mkOption {
            description = ''
              Domain used for media vhosts
            '';
            type = types.str;
            default = "home.boerger.ws";
          };
        };
      };
    };
  };

  config = with lib; mkIf cfg.enable {
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
        heimdall = {
          enable = true;
        };

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
        };

        radarr = {
          enable = true;
          user = "media";
          group = "media";
        };

        sonarr = {
          enable = true;
          user = "media";
          group = "media";
        };

        lidarr = {
          enable = true;
          user = "media";
          group = "media";
        };

        readarr = {
          enable = true;
          user = "media";
          group = "media";

          package = pkgs.nur.repos.tboerger.readarr;
        };

        bazarr = {
          enable = true;
          user = "media";
          group = "media";
        };

        prowlarr = {
          enable = true;
          user = "media";
          group = "media";
        };

        unpackerr = {
          enable = true;
          user = "media";
          group = "media";
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
          allowedUDPPorts = [ 1900 7359 ];
        };
      };
    };
}
