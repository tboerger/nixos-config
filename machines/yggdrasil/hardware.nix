{ config, lib, pkgs, ... }:

{
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    raspberry-pi = {
      "4" = {
        fkms-3d = {
          enable = true;
        };
      };
    };
  };
}
