{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages;
    cleanTmpDir = true;

    kernelModules = [
      "kvm-intel"
      "wl"
    ];

    extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
    ];

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

    binfmt = {
      emulatedSystems = [
        "armv7l-linux"
        "aarch64-linux"
      ];
    };
  };
}
