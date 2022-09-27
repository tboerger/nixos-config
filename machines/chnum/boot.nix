{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages;
    cleanTmpDir = true;

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      systemd-boot = {
        enable = true;
        consoleMode = "2";
        editor = false;
      };
    };

    kernelModules = [
      "kvm-intel"
    ];

    extraModulePackages = [

    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      kernelModules = [
        "dm-snapshot"
      ];
    };
  };
}
