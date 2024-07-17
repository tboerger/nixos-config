{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    prometheus = {
      exporters = {
        postgres = {
          enable = true;
          openFirewall = true;
          runAsLocalSuperUser = true;
        };
      };
    };

    postgresql = {
      enable = true;

      ensureDatabases = [
        "nextcloud"
      ];

      ensureUsers = [{
        name = "nextcloud";
        ensureDBOwnership = true;
      }];
    };

    postgresqlBackup = {
      enable = true;

      databases = [
        "nextcloud"
      ];
    };
  };

  systemd = {
    services = {
      nextcloud-setup = {
        after = [ "postgresql.service" ];
        requires = [ "postgresql.service" ];
      };
    };
  };
}
