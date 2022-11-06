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
      grub = {
        enable = true;
        version = 2;
        device = "/dev/disk/by-path/pci-0000:00:14.1-ata-1";
        efiSupport = false;
      };
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "ahci" "ehci_pci" "ohci_pci" "pata_atiixp" "sd_mod" "usb_storage" "usbhid" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
