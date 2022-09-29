{ config, lib, pkgs, ... }:

{
  boot = {
    binfmt = {
      emulatedSystems = [
        "aarch64-linux"
        "armv6l-linux"
      ];
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages;
    cleanTmpDir = true;

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
    };

    kernelModules = [
      "kvm-intel"
    ];

    extraModulePackages = [

    ];

    initrd = {
      availableKernelModules = [
        "ahci"
        "atkbd"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "xhci_pci"
      ];

      kernelModules = [
        "dm-snapshot"
      ];
    };
  };
}
