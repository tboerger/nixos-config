{ config, lib, pkgs, ... }:

{
  boot = {
    binfmt = {
      emulatedSystems = [
        "aarch64-linux"
      ];
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    tmp = {
      cleanOnBoot = true;
    };

    loader = {
      grub = {
        enable = true;
        efiSupport = false;
        copyKernels = true;
      };
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = with config.boot.kernelPackages; [ ];

    initrd = {
      availableKernelModules = [ "ahci" "ehci_pci" "ohci_pci" "pata_atiixp" "sd_mod" "usb_storage" "usbhid" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
