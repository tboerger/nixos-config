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
        efiSupport = false;
        copyKernels = true;

        devices = [
          "/dev/disk/by-path/pci-0000:00:1f.2-ata-3.0"
          "/dev/disk/by-path/pci-0000:00:1f.2-ata-4.0"
          "/dev/disk/by-path/pci-0000:00:1f.2-ata-5.0"
          "/dev/disk/by-path/pci-0000:00:1f.2-ata-6.0"
        ];
      };
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "ehci_pci" "ahci" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
