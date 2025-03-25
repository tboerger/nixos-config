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
          hashedPasswordFile = config.age.secrets."users/media/password".path;
        };
        printer = {
          uid = 20001;
          description = "Printer";
          shell = pkgs.zsh;
          isSystemUser = true;
          group = "printer";
          home = "/var/lib/printer";
          hashedPasswordFile = config.age.secrets."users/printer/password".path;
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
        # securityType = "user";

        # extraConfig = ''
        #   workgroup = WORKGROUP
        #   server string = Server
        #   netbios name = Server
        #   guest account = nobody
        #   map to guest = bad user
        #   server min protocol = SMB2
        # '';

        # shares = {
        #   shares = {
        #     comment = "General shares";
        #     path = "/var/lib/shares";

        #     "browseable" = "yes";
        #     "read only" = "no";
        #     "writeable" = "yes";
        #     "guest ok" = "yes";
        #     "force user" = "media";
        #     "force group" = "media";
        #   };

        #   photos = {
        #     comment = "Shared photos";
        #     path = "/var/lib/photos";

        #     "browseable" = "yes";
        #     "read only" = "no";
        #     "writeable" = "yes";
        #     "guest ok" = "yes";
        #     "force user" = "media";
        #     "force group" = "media";
        #   };

        #   videos = {
        #     comment = "Shared videos";
        #     path = "/var/lib/videos";

        #     "browseable" = "yes";
        #     "read only" = "no";
        #     "writeable" = "yes";
        #     "guest ok" = "yes";
        #     "force user" = "media";
        #     "force group" = "media";
        #   };

        #   printer = {
        #     comment = "Shared printer";
        #     path = "/var/lib/printer";

        #     "browseable" = "yes";
        #     "read only" = "no";
        #     "writeable" = "yes";
        #     "guest ok" = "yes";
        #     "force user" = "printer";
        #     "force group" = "printer";
        #   };

        #   backup = {
        #     comment = "Shared backup";
        #     path = "/var/lib/backup/%u";

        #     "browseable" = "yes";
        #     "read only" = "no";
        #     "writeable" = "yes";
        #     "guest ok" = "no";
        #   };
        # };
      };

      samba-wsdd = {
        enable = true;
      };
    };

    age.secrets."users/media/password" = {
      file = ../../secrets/users/media/password.age;
    };

    age.secrets."users/printer/password" = {
      file = ../../secrets/users/printer/password.age;
    };
  };
}
