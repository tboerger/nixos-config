{
  pkgs,
  config,
  lib,
  ...
}:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        nextcloud = {
          enable = true;
          openFirewall = true;
          user = "nextcloud";
          group = "nextcloud";
          url = "https://cloud.boerger.ws";
          username = "devops";
          passwordFile = "/run/agenix/services/cloud/password";
        };
      };
    };

    nextcloud = {
      enable = true;

      package = pkgs.nextcloud34;

      https = true;
      hostName = "cloud.boerger.ws";

      maxUploadSize = "1024M";

      configureRedis = true;
      webfinger = true;
      extraAppsEnable = true;

      config = {
        adminuser = "devops";
        adminpassFile = "/run/agenix/services/cloud/password";

        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        dbuser = "nextcloud";
        dbname = "nextcloud";
      };

      settings = {
        trusted_proxies = [ ];

        default_phone_region = "DE";
        overwriteProtocol = "https";

        loglevel = 2;
        logtype = "systemd";
      };

      notify_push = {
        enable = true;
      };

      autoUpdateApps = {
        enable = true;
      };

      extraApps = {
        inherit (pkgs.nextcloud34Packages.apps)
          calendar
          contacts
          cookbook
          groupfolders
          impersonate
          polls
          ;
      };
    };
  };
}
