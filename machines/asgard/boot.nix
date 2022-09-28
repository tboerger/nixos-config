{ config, lib, pkgs, ... }:

{
  boot = {
    binfmt = {
      emulatedSystems = [
        "aarch64-linux"
        "armv6l-linux"
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
        editor = false;
      };
    };

    kernelModules = [

    ];

    extraModulePackages = [

    ];

    initrd = {
      availableKernelModules = [

      ];

      kernelModules = [
        "dm-snapshot"
      ];
    };
  };
}
