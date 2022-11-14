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
        devices = [ "/dev/disk/by-path/pci-0000:00:1f.2-ata-1.0" "/dev/disk/by-path/pci-0000:00:1f.2-ata-2.0" ];
        efiSupport = false;
      };
    };

    kernelModules = [ ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "uhci_hcd" "ehci_pci" "ahci" "usbhid" "sd_mod" "sr_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
