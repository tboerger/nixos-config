{ config, lib, pkgs, ... }:

{
  boot = {
    cleanTmpDir = true;
    consoleLogLevel = lib.mkDefault 7;
    kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi1;

    kernelParams = [
      "dwc_otg.lpm_enable=0"
      "console=ttyAMA0,115200"
      "rootwait"
      "elevator=deadline"
    ];

    loader = {
      grub = {
        enable = lib.mkDefault false;
      };

      generic-extlinux-compatible = {
        enable = true;
      };

      generationsDir = {
        enable = lib.mkDefault false;
      };

      raspberryPi = {
        enable = lib.mkDefault true;
        version = lib.mkDefault 1;
      };
    };
  };
}
