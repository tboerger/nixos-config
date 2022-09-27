{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_rpi4;
    cleanTmpDir = true;
  };
}
