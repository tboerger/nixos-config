{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules
    ../services

    ./filesystems.nix
    ./hardware.nix
    ./networking.nix
  ];

  personal = {
    services = {
      acme = {
        enable = true;
      };
      dyndns = {
        enable = true;
      };
      media = {
        enable = true;
      };
      unifi = {
        enable = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      intel-media-driver
    ];
  };

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

  system = {
    stateVersion = "21.11";
  };
}
