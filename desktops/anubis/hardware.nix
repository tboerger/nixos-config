{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    cpu = {
      intel = {
        updateMicrocode = lib.mkDefault true;
      };
    };

    nvidia = {
      prime = {
        sync = {
          enable = true;
        };

        nvidiaBusId = "PCI:3:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
  };

  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };
}
