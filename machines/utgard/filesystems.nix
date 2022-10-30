{ config, lib, pkgs, ... }:
let
  cifsServer = "//192.168.1.10";
  cifsOptions = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "credentials=${config.age.secrets."users/media/smbpasswd".path}"
    "uid=${toString config.users.users.media.uid}"
    "gid=${toString config.users.groups.media.gid}"
  ];

in
{
  environment = {
    systemPackages = with pkgs; [
      cifs-utils
    ];
  };

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/var/lib/acme" = {
    device = "/dev/disk/by-label/acme";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/nzbget" = {
    device = "/dev/disk/by-label/nzbget";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/jellyfin" = {
    device = "/dev/disk/by-label/jellyfin";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/bazarr" = {
    device = "/dev/disk/by-label/bazarr";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/lidarr" = {
    device = "/dev/disk/by-label/lidarr";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/prowlarr" = {
    device = "/dev/disk/by-label/prowlarr";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/radarr" = {
    device = "/dev/disk/by-label/radarr";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/readarr" = {
    device = "/dev/disk/by-label/readarr";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/sonarr" = {
    device = "/dev/disk/by-label/sonarr";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/hass" = {
    device = "/dev/disk/by-label/hass";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/downloads" = {
    device = "/dev/disk/by-label/downloads";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/movies" = {
    device = "${cifsServer}/movies";
    fsType = "cifs";
    options = cifsOptions;
  };

  fileSystems."/var/lib/media/shows" = {
    device = "${cifsServer}/shows";
    fsType = "cifs";
    options = cifsOptions;
  };

  fileSystems."/var/lib/media/books" = {
    device = "${cifsServer}/books";
    fsType = "cifs";
    options = cifsOptions;
  };

  fileSystems."/var/lib/media/music" = {
    device = "${cifsServer}/music";
    fsType = "cifs";
    options = cifsOptions;
  };

  age.secrets."users/media/smbpasswd" = {
    file = ../../secrets/users/media/smbpasswd.age;
  };
}
