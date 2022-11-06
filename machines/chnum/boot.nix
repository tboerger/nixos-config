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
        configurationLimit = 5;
        editor = false;
      };
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "ahci" "atkbd" "rtsx_pci_sdmmc" "sd_mod" "usb_storage" "xhci_pci" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
