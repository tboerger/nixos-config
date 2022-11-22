{ config, lib, pkgs, ... }:

{
  boot = {
    binfmt = {
      emulatedSystems = [
        "aarch64-linux"
      ];
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    cleanTmpDir = true;

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };

      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
      };
    };

    # kernelParams = [ "intel_pstate=no_hwp" ];

    kernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "acpi_call" "cryptd" ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
