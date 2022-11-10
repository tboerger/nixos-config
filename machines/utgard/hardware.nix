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
  };

  environment = {
    systemPackages = with pkgs; [
      intel-gpu-tools
    ];
  };
}
