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

  fileSystems."/var/lib/media/shares" = {
    device = "/dev/disk/by-label/shares";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/photos" = {
    device = "/dev/disk/by-label/photos";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/videos" = {
    device = "/dev/disk/by-label/videos";
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

  fileSystems."/var/lib/media/shows" = {
    device = "/dev/disk/by-label/shows";
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

  fileSystems."/var/lib/media/music" = {
    device = "/dev/disk/by-label/music";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/downloads" = {
    device = "/dev/disk/by-label/downloads";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/printer" = {
    device = "/dev/disk/by-label/printer";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/backup" = {
    device = "/dev/disk/by-label/backup";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };
}
