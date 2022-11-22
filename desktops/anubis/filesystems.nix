{ config, lib, pkgs, ... }:

{
  boot = {
    initrd = {
      luks = {
        devices = {
          luks = {
            name = "luks";
            device = "/dev/disk/by-partlabel/system";
            preLVM = true;
            allowDiscards = true;
          };
        };
      };
    };
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
}
