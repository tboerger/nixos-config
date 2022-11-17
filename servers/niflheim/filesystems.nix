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
}
