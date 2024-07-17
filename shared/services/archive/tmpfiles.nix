{ pkgs, config, lib, ... }:
with lib;

{
  systemd = {
    tmpfiles = {
      rules = [



        "d /var/lib/sabnzbd 0700 media users"
        "d /var/lib/radarr 0700 media users"
        "d /var/lib/sonarr 0700 media users"
        "d /var/lib/lidarr 0700 media users"
        "d /var/lib/prowlarr 0700 media users"
        "d /var/lib/bazarr 0700 media users"
        "d /var/lib/filebrowser 0700 media users"

        "d /var/lib/music 0700 media users"



      ];
    };
  };
}
