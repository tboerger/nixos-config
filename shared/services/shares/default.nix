{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.shares;

in
{
  options = {
    personal = {
      services = {
        shares = {
          enable = mkEnableOption "Shares";
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

    networking = {
      firewall = {
        allowedTCPPorts = [
          2049
          5357
        ];

        allowedUDPPorts = [
          3702
        ];
      };
    };

    services = {
      nfs = {
        server = {
          enable = true;

          exports = ''
            /exports 192.168.1.0/255.255.255.0(rw,fsid=0,no_subtree_check)
            /exports/shares 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
            /exports/photos 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
            /exports/videos 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
            /exports/movies 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
            /exports/shows 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
            /exports/books 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
            /exports/music 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
            /exports/printer 192.168.1.0/255.255.255.0(rw,nohide,insecure,no_subtree_check)
          '';
        };
      };

      samba = {
        enable = true;
        openFirewall = true;
        securityType = "user";

        extraConfig = ''
          workgroup = WORKGROUP
          server string = Server
          netbios name = Server
          guest account = nobody
          map to guest = bad user
          server min protocol = SMB2
        '';

        shares = {
          shares = {
            comment = "General shares";
            path = "/var/lib/shares";

            "browseable" = "yes";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "yes";
            "force user" = "media";
            "force group" = "media";
          };

          photos = {
            comment = "Shared photos";
            path = "/var/lib/photos";

            "browseable" = "yes";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "yes";
            "force user" = "media";
            "force group" = "media";
          };

          videos = {
            comment = "Shared videos";
            path = "/var/lib/videos";

            "browseable" = "yes";
            "read only" = "no";
            "writeable" = "yes";
            "guest ok" = "yes";
            "force user" = "media";
            "force group" = "media";
          };

          movies = {
            comment = "Shared movies";
            path = "/var/lib/movies";

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
            path = "/var/lib/shows";

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
            path = "/var/lib/books";

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
            path = "/var/lib/music";

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

      samba-wsdd = {
        enable = true;
      };
    };

    age.secrets."users/printer/password" = {
      file = ../../../secrets/users/printer/password.age;
    };

    age.secrets."users/media/password" = {
      file = ../../../secrets/users/media/password.age;
    };
  };
}
