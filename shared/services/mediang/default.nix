{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.services.mediang;

in
{
  options = {
    personal = {
      services = {
        mediang = {
          enable = mkEnableOption "Media";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # networking = {
    #   nat = {
    #     enable = true;
    #     internalInterfaces = ["ve-+"];
    #     externalInterface = "ens3";
    #   };
    # };

    containers = {
      media =
        let
          passwordFile = config.age.secrets."users/media/password".path;
        in
        {
          autoStart = true;
          privateNetwork = true;
          # hostAddress = "192.168.100.10";
          # localAddress = "192.168.100.11";

          config = { config, pkgs, ... }: {
            users = {
              users = {
                media = {
                  uid = 20000;
                  description = "Media";
                  shell = pkgs.zsh;
                  isSystemUser = true;
                  group = "media";
                  home = "/var/lib/media";
                  passwordFile = passwordFile;
                };
              };

              groups = {
                media = {
                  gid = 20000;
                };
              };
            };

            services = {
              jellyfin = {
                enable = true;
                user = "media";
                group = "media";
                package = pkgs.jellyfin;
              };
            };

            networking.firewall = {
              enable = true;
              allowedTCPPorts = [
                8080
              ];
            };

            environment.etc."resolv.conf".text = "nameserver 8.8.8.8";
            system.stateVersion = "22.05";
          };
        };
    };

    age.secrets."users/media/password" = {
      file = ../../../secrets/users/media/password.age;
    };
  };
}

# services = {
#   nzbget = {
#     enable = true;
#     user = "media";
#     group = "media";

#     settings = {
#       MainDir = "/var/lib/downloads";
#       DestDir = "/var/lib/downloads/completed";
#       InterDir = "/var/lib/downloads/intermediate";
#       NzbDir = "/var/lib/downloads/nzb";
#       QueueDir = "/var/lib/downloads/queue";
#       TempDir = "/var/lib/downloads/temp";
#       ScriptDir = "/var/lib/downloads/scripts";

#       "Category1.Name" = "Movies";
#       "Category1.Unpack" = "yes";

#       "Category2.Name" = "Series";
#       "Category2.Unpack" = "yes";

#       "Category3.Name" = "Music";
#       "Category3.Unpack" = "yes";

#       "Category4.Name" = "Books";
#       "Category4.Unpack" = "yes";

#       "Category5.Name" = "Prowlarr";
#       "Category5.Unpack" = "yes";
#     };
#   };

#   jellyfin = {
#     enable = true;
#     user = "media";
#     group = "media";
#     package = pkgs.jellyfin;
#   };

#   radarr = {
#     enable = true;
#     user = "media";
#     group = "media";
#     package = pkgs.radarr;
#     dataDir = "/var/lib/radarr";
#   };

#   sonarr = {
#     enable = true;
#     user = "media";
#     group = "media";
#     package = pkgs.sonarr;
#     dataDir = "/var/lib/sonarr";
#   };

#   lidarr = {
#     enable = true;
#     user = "media";
#     group = "media";
#     package = pkgs.lidarr;
#     dataDir = "/var/lib/lidarr";
#   };

#   readarr = {
#     enable = true;
#     user = "media";
#     group = "media";
#     package = pkgs.nur.repos.tboerger.readarr;
#     dataDir = "/var/lib/readarr";
#   };

#   bazarr = {
#     enable = true;
#     user = "media";
#     group = "media";
#     package = pkgs.bazarr;
#   };

#   prowlarr = {
#     enable = true;
#     user = "media";
#     group = "media";
#     package = pkgs.prowlarr;
#   };

#   nginx = {
#     virtualHosts =
#       let
#         base = locations: {
#           inherit locations;

#           useACMEHost = "boerger.ws";
#           forceSSL = true;
#         };
#         proxy = port: base {
#           "/" = {
#             proxyPass = "http://127.0.0.1:" + toString (port) + "/";
#             proxyWebsockets = true;
#           };
#         };
#       in
#       {
#         "nzbget.boerger.ws" = proxy 6789;
#         "jellyfin.boerger.ws" = proxy 8096;
#         "radarr.boerger.ws" = proxy 7878;
#         "sonarr.boerger.ws" = proxy 8989;
#         "lidarr.boerger.ws" = proxy 8686;
#         "readarr.boerger.ws" = proxy 8787;
#         "bazarr.boerger.ws" = proxy 6767;
#         "prowlarr.boerger.ws" = proxy 9696;
#       };
#   };
# };

# personal = {
#   services = {
#     webserver = {
#       enable = true;
#     };
#   };
# };

# networking = {
#   firewall = {
#     allowedTCPPorts = [ 8096 ];
#     allowedUDPPorts = [ 1900 7359 ];
#   };
# };
