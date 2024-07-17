{ pkgs, config, lib, ... }:
with lib;

{
  systemd = {
    tmpfiles = {
      rules = [
        "d /var/lib/photoprism 0700 photoprism photoprism"
        "d /var/lib/originals 0700 photoprism photoprism"
      ];
    };
  };
}
