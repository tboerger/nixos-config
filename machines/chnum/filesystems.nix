{ config, lib, pkgs, ... }:

{
  boot = {
    initrd = {
      luks = {
        devices = [{
          name = "luks";
          device = "/dev/disk/by-label/data";
          preLVM = true;
          allowDiscards = true;
        }];
      };
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
    options = [
      "noatime"
      "nodiratime"
      "discard"
    ];
  };

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];
}
