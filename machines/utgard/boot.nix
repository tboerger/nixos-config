{ config, lib, pkgs, ... }:

{
  boot = {
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
