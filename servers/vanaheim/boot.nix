{ config, lib, pkgs, ... }:

{
  boot = {
    binfmt = {
      emulatedSystems = [
        "aarch64-linux"
      ];
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages;

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

    kernelModules = [ ];
    extraModulePackages = with config.boot.kernelPackages; [ ];

    initrd = {
      availableKernelModules = [ ];
      kernelModules = [ "dm-snapshot" ];
    };
  };
}
