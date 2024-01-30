{ config, lib, pkgs, ... }:

{
  hardware = {
    nvidia = {
      powerManagement = {
        enable = true;
      };

      modesetting = {
        enable = true;
      };

      prime = {
        sync = {
          enable = true;
        };

        nvidiaBusId = "PCI:3:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
  };
}
