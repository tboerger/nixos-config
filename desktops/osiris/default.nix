{ config, lib, pkgs, ... }:

{
  imports = [
    ../../shared/modules
    ../../shared/programs
    ../../shared/services

    ./filesystems.nix
    ./boot.nix
    ./networking.nix
    ./hardware.nix
  ];

  personal = {
    # programs = {
    #   citrix = {
    #     enable = config.personal.programs.enable;
    #   };
    # };

    services = {
      desktop = {
        enable = config.personal.services.enable;
      };
      docker = {
        enable = config.personal.services.enable;
      };
      libvirt = {
        enable = config.personal.services.enable;
      };
      tailscale = {
        enable = config.personal.services.enable;
      };
    };
  };

  system = {
    stateVersion = "21.11";
  };
}
