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
        };
      };
    };
  };

  config = mkIf cfg.enable {
    users = {
      users = {
        media = {
          uid = 20000;
          description = "Media";
          shell = pkgs.zsh;
          isSystemUser = true;
          group = "media";
          home = "/var/lib/media";
          passwordFile = config.age.secrets."users/media/password".path;
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
          MainDir = "/var/lib/downloads";
          DestDir = "/var/lib/downloads/completed";
          InterDir = "/var/lib/downloads/intermediate";
          NzbDir = "/var/lib/downloads/nzb";
          QueueDir = "/var/lib/downloads/queue";
          TempDir = "/var/lib/downloads/temp";
          ScriptDir = "/var/lib/downloads/scripts";

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

      radarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.radarr;
        dataDir = "/var/lib/radarr";
      };

      sonarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.sonarr;
        dataDir = "/var/lib/sonarr";
      };

      lidarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.lidarr;
        dataDir = "/var/lib/lidarr";
      };

      readarr = {
        enable = true;
        user = "media";
        group = "media";
        package = pkgs.nur.repos.tboerger.readarr;
        dataDir = "/var/lib/readarr";
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

      # unpackerr = {
      #   enable = true;
      #   user = "media";
      #   group = "media";
      #   # package = pkgs.unpackerr;
      # };
    };

    personal = {
      services = {
        webserver = {
          enable = true;

          hosts = [
            {
              domain = "nzbget.boerger.ws";
              proxy = "http://localhost:6789";
            }
            {
              domain = "jellyfin.boerger.ws";
              proxy = "http://localhost:8096";
            }
            {
              domain = "radarr.boerger.ws";
              proxy = "http://localhost:7878";
            }
            {
              domain = "sonarr.boerger.ws";
              proxy = "http://localhost:8989";
            }
            {
              domain = "lidarr.boerger.ws";
              proxy = "http://localhost:8686";
            }
            {
              domain = "readarr.boerger.ws";
              proxy = "http://localhost:8787";
            }
            {
              domain = "bazarr.boerger.ws";
              proxy = "http://localhost:6767";
            }
            {
              domain = "prowlarr.boerger.ws";
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

    age.secrets."users/media/password" = {
      file = ../../secrets/users/media/password.age;
    };
  };
}
