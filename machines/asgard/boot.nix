{ config, lib, pkgs, ... }:

{
  boot = {
    binfmt = {
      emulatedSystems = [
        "aarch64-linux"
      ];
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages;
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
      "kvm-amd"
    ];

    extraModulePackages = [

    ];

    initrd = {
      availableKernelModules = [
        "ahci"
        "ehci_pci"
        "ohci_pci"
        "pata_atiixp"
        "sd_mod"
        "usb_storage"
        "usbhid"
      ];

      kernelModules = [
        "dm-snapshot"
      ];
    };
  };
}
