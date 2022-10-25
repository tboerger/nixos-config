{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.samba;

in
{
  options = {
    personal = {
      services = {
        samba = {
          enable = mkEnableOption "Samba";
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
        printer = {
          uid = 20001;
          description = "Printer";
          shell = pkgs.zsh;
          isSystemUser = true;
          group = "printer";
          home = "/var/lib/printer";
          passwordFile = config.age.secrets."users/printer/password".path;
        };
      };

      groups = {
        media = {
          gid = 20000;
        };
        printer = {
          gid = 20001;
        };
      };
    };

    services = {
      samba = {
        enable = true;
        openFirewall = true;

        extraConfig = ''
          workgroup = WORKGROUP
          server string = Sharing
          netbios name = Sharing
          guest account = nobody
          map to guest = bad user
        '';

        shares = {
          photos = {
            comment = "Shared photos";
            path = "/var/lib/media/photos";

            "browseable" = "yes";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "yes";
            "force user" = "media";
            "force group" = "media";
          };

          videos = {
            comment = "Shared videos";
            path = "/var/lib/media/videos";

            "browseable" = "yes";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "yes";
            "force user" = "media";
            "force group" = "media";
          };

          movies = {
            comment = "Shared movies";
            path = "/var/lib/media/movies";

            "browseable" = "no";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "no";
            "force user" = "media";
            "force group" = "media";
            "valid users" = "media";
          };

          shows = {
            comment = "Shared shows";
            path = "/var/lib/media/shows";

            "browseable" = "no";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "no";
            "force user" = "media";
            "force group" = "media";
            "valid users" = "media";
          };

          books = {
            comment = "Shared books";
            path = "/var/lib/media/books";

            "browseable" = "no";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "no";
            "force user" = "media";
            "force group" = "media";
            "valid users" = "media";
          };

          music = {
            comment = "Shared music";
            path = "/var/lib/media/music";

            "browseable" = "no";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "no";
            "force user" = "media";
            "force group" = "media";
            "valid users" = "media";
          };

          downloads = {
            comment = "Shared downloads";
            path = "/var/lib/media/downloads";

            "browseable" = "no";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "no";
            "force user" = "media";
            "force group" = "media";
            "valid users" = "media";
          };

          printer = {
            comment = "Shared printer";
            path = "/var/lib/printer";

            "browseable" = "yes";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "yes";
            "force user" = "printer";
            "force group" = "printer";
          };

          backup = {
            comment = "Shared backup";
            path = "/var/lib/backup/%u";

            "browseable" = "yes";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "no";
          };
        };
      };
    };

    age.secrets."users/printer/password" = {
      file = ../../secrets/users/printer/password.age;
    };

    age.secrets."users/media/password" = {
      file = ../../secrets/users/media/password.age;
    };
  };
}
