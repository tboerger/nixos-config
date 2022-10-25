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

      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = false;
      };
    };

    kernelModules = [
      "kvm-intel"
      "wl"
    ];

    extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
    ];

    initrd = {
      availableKernelModules = [
        "uhci_hcd"
        "ehci_pci"
        "ahci"
        "firewire_ohci"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "sdhci_pci"
      ];

      kernelModules = [
        "dm-snapshot"
      ];
    };
  };
}
