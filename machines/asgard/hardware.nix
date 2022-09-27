{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };
}
