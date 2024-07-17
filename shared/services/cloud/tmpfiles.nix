{ pkgs, config, lib, ... }:
with lib;

{
  systemd = {
    tmpfiles = {
      rules = [
        "d /var/lib/postgresql 0750 postgres postgres"
        "d /var/lib/redis 0750 redis-nextcloud redis-nextcloud"
      ];
    };
  };
}
