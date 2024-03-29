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

    kernelModules = [ "coretemp" "thinkpad_acpi" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "acpi_call" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
