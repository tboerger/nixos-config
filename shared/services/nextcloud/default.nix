{ pkgs, lib, config, options, fetchurl, ... }:
with lib;

let
  cfg = config.personal.services.nextcloud;

in
{
  options = {
    personal = {
      services = {
        nextcloud = {
          enable = mkEnableOption "Nextcloud";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # containers = {
    #   nextcloud = {
    #     autoStart = true;
    #     privateNetwork = true;
    #     hostAddress = "192.168.101.10";
    #     localAddress = "192.168.101.11";

    #     config = { config, pkgs, ... }: {
    #       services = {
    #         mysql = {
    #           enable = true;

    #           ensureDatabases = [
    #             "nextcloud"
    #           ];

    #           ensureUsers = [{
    #             name = "nextcloud";
    #             ensurePermissions = {
    #               "*.*" = "ALL PRIVILEGES";
    #             };
    #           }];
    #         };

    #         nextcloud = {
    #           enable = true;
    #           package = pkgs.nextcloud25;

    #           hostName = "cloud.boerger.ws";
    #           https = true;
    #           extraAppsEnable = true;
    #           globalProfiles = false;
    #           logType = "systemd";
    #           maxUploadSize = "1024M";
    #           secretFile = null;

    #           trustedProxies = [
    #             "192.168.101.0/24"
    #           ];

    #           config = {
    #             overwriteProtocol = "https";

    #             adminuser = "devops";
    #             adminpassFile = "";

    #             dbtype = "mysql";
    #             dbname = "nextcloud";
    #             dbhost = "/run/mysql/mysql.sock";
    #             dbuser = "nextcloud";
    #             dbpassFile = null;

    #             defaultPhoneRegion = "DE";

    #             objectstore = {
    #               s3 = {
    #                 enabel = true;
    #                 hostname = "s3.eu-west-1.wasabisys.com"
    #                 port = 443
    #                 region = "eu-west-1";
    #                 bucket = "bws-nextcloud";
    #                 key = "";
    #                 secretFile = "";
    #               }
    #             };
    #           };

    #           caching = {
    #             redis = true;
    #           };

    #           extraOptions = {
    #             redis = {
    #               host = "/run/redis/redis.sock";
    #               port = 0;
    #               dbindex = 0;
    #               password = "secret";
    #               timeout = 1.5;
    #             };
    #           };

    #           # extraApps = {
    #           #   bookmarks = pkgs.fetchNextcloudApp {
    #           #     name = "bookmarks";
    #           #     sha256 = "";
    #           #     url = "https://github.com/nextcloud/bookmarks/releases/download/v11.0.4/bookmarks-11.0.4.tar.gz";
    #           #     version = "11.0.4";
    #           #   };
    #           #   cookbook = pkgs.fetchNextcloudApp {
    #           #     name = "cookbook";
    #           #     sha256 = "";
    #           #     url = "https://github.com/nextcloud/cookbook/releases/download/v0.10.1/Cookbook-0.10.1.tar.gz";
    #           #     version = "0.10.1";
    #           #   };
    #           #   drawio = pkgs.fetchNextcloudApp {
    #           #     name = "drawio";
    #           #     sha256 = "";
    #           #     url = "https://github.com/jgraph/drawio-nextcloud/releases/download/v1.0.5/drawio-v1.0.5.tar.gz";
    #           #     version = "1.0.5";
    #           #   };
    #           #   guests = pkgs.fetchNextcloudApp {
    #           #     name = "guests";
    #           #     sha256 = "";
    #           #     url = "https://github.com/nextcloud/guests/releases/download/v2.3.0/guests.tar.gz";
    #           #     version = "2.3.0";
    #           #   };
    #           #   impersonate = pkgs.fetchNextcloudApp {
    #           #     name = "impersonate";
    #           #     sha256 = "";
    #           #     url = "https://github.com/nextcloud/impersonate/releases/download/v1.8.0/impersonate.tar.gz";
    #           #     version = "1.8.0";
    #           #   };
    #           # };
    #         };
    #       };

    #       networking = {
    #         firewall = {
    #           enable = true;
    #         };
    #       };

    #       systemd = {
    #         tmpfiles = {
    #           rules = [
    #             "d /var/lib/nextcloud 700 nextcloud nextcloud -"
    #           ];
    #         };
    #       };

    #       environment.etc."resolv.conf".text = "nameserver 1.1.1.1";
    #       system.stateVersion = "22.05";
    #     };

    #     bindMounts = {
    #       "/var/lib/nextcloud" = {
    #         hostPath = "/var/lib/nextcloud/";
    #         isReadOnly = false;
    #       };
    #     };
    #   };
    # };
  };
}
