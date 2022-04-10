{ config, lib, pkgs, ... }:

{
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

  fileSystems."/var/lib/media/downloads" = {
    device = "/dev/disk/by-label/downloads";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/movies" = {
    device = "/dev/disk/by-label/movies";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/series" = {
    device = "/dev/disk/by-label/series";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/books" = {
    device = "/dev/disk/by-label/books";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
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
}
