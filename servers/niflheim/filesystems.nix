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
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nix";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/acme" = {
    device = "/dev/disk/by-label/acme";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/nzbget" = {
    device = "/dev/disk/by-label/nzbget";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/jellyfin" = {
    device = "/dev/disk/by-label/jellyfin";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/radarr" = {
    device = "/dev/disk/by-label/radarr";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/sonarr" = {
    device = "/dev/disk/by-label/sonarr";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/lidarr" = {
    device = "/dev/disk/by-label/lidarr";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/readarr" = {
    device = "/dev/disk/by-label/readarr";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/bazarr" = {
    device = "/dev/disk/by-label/bazarr";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/prowlarr" = {
    device = "/dev/disk/by-label/prowlarr";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/downloads" = {
    device = "/dev/disk/by-label/downloads";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/movies" = {
    device = "/dev/disk/by-label/movies";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/shows" = {
    device = "/dev/disk/by-label/shows";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/books" = {
    device = "/dev/disk/by-label/books";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/music" = {
    device = "/dev/disk/by-label/music";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/bromance" = {
    device = "/dev/disk/by-label/bromance";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/var/lib/owntech" = {
    device = "/dev/disk/by-label/owntech";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };
}
