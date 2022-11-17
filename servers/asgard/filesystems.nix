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

  fileSystems."/var/lib/shares" = {
    device = "/dev/disk/by-label/shares";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/exports/shares" = {
    device = "/var/lib/shares";
    options = [
      "bind"
    ];
  };

  fileSystems."/var/lib/photos" = {
    device = "/dev/disk/by-label/photos";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/exports/photos" = {
    device = "/var/lib/photos";
    options = [
      "bind"
    ];
  };

  fileSystems."/var/lib/videos" = {
    device = "/dev/disk/by-label/videos";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/exports/videos" = {
    device = "/var/lib/videos";
    options = [
      "bind"
    ];
  };

  fileSystems."/var/lib/printer" = {
    device = "/dev/disk/by-label/printer";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/exports/printer" = {
    device = "/var/lib/printer";
    options = [
      "bind"
    ];
  };

  fileSystems."/var/lib/backup" = {
    device = "/dev/disk/by-label/backup";
    fsType = "ext4";
    options = [
      "noatime"
    ];
  };

  fileSystems."/exports/backup" = {
    device = "/var/lib/backup";
    options = [
      "bind"
    ];
  };
}
