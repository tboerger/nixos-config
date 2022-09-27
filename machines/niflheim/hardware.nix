{ config, lib, pkgs, ... }:

{
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  powerManagement = {
    enable = lib.mkDefault false;
  };
}
