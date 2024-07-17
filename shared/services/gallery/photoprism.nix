{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    photoprism = {
      enable = true;
      address = "0.0.0.0";
      storagePath = "/var/lib/photoprism";
      originalsPath = "/var/lib/originals";

      passwordFile = "/run/agenix/services/gallery/password";

      settings = {
        PHOTOPRISM_ADMIN_USER = "devops";

        PHOTOPRISM_SITE_URL = "https://gallery.boerger.ws";
        PHOTOPRISM_SITE_AUTHOR = "Thomas Boerger";
        PHOTOPRISM_SITE_TITLE = "Boergers";
        PHOTOPRISM_SITE_CAPTION = "Everything totally uncensored";
        PHOTOPRISM_SITE_DESCRIPTION = "Family photos and videos of the Boergers";

        PHOTOPRISM_WORKERS = "4";
        PHOTOPRISM_EXPERIMENTAL = "true";
        PHOTOPRISM_DETECT_NSFW = "false";
        PHOTOPRISM_UPLOAD_NSFW = "true";
      };
    };
  };

  systemd = {
    services = {
      photoprism = {
        serviceConfig = {
          DynamicUser = mkForce false;
        };
      };
    };
  };

  users = {
    users = {
      photoprism = {
        home = "/var/lib/photoprism";
        group = "photoprism";
        isSystemUser = true;
      };
    };

    groups = {
      photoprism = { };
    };
  };
}
