{ config, lib, pkgs, ... }:
let
  nfsOptions = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "nfsvers=4.2"
  ];

in
{
  environment = {
    systemPackages = with pkgs; [
      nfs-utils
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

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nix";
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

  fileSystems."/var/lib/movies" = {
    device = "192.168.1.10:/movies";
    fsType = "nfs";
    options = nfsOptions;
  };

  fileSystems."/var/lib/shows" = {
    device = "192.168.1.10:/shows";
    fsType = "nfs";
    options = nfsOptions;
  };

  fileSystems."/var/lib/books" = {
    device = "192.168.1.10:/books";
    fsType = "nfs";
    options = nfsOptions;
  };

  fileSystems."/var/lib/music" = {
    device = "192.168.1.10:/music";
    fsType = "nfs";
    options = nfsOptions;
  };
}
