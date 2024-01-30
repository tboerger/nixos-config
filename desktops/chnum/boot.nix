{ config, lib, pkgs, ... }:

{
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];

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
    extraModulePackages = with config.boot.kernelPackages; [ ];

    initrd = {
      availableKernelModules = [ "ahci" "atkbd" "rtsx_pci_sdmmc" "sd_mod" "usb_storage" "xhci_pci" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
