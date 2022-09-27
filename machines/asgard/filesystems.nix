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

  fileSystems."/var/lib/media/cloud" = {
    device = "/dev/disk/by-label/cloud";
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

  fileSystems."/var/lib/media/music" = {
    device = "/dev/disk/by-label/music";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };

  fileSystems."/var/lib/media/shares" = {
    device = "/dev/disk/by-label/shares";
    fsType = "ext4";
    options = [
      "noatime"
      "discard"
    ];
  };
}
