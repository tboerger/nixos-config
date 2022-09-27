{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages;
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
