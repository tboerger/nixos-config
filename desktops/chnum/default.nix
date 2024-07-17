{ config, lib, pkgs, ... }:

{
  imports = [
    ../../shared/modules
    ../../shared/global
    ../../shared/programs
    ../../shared/services

    ./disko.nix
    ./boot.nix
    ./networking.nix
    ./graphics.nix
    ./hardware.nix
    ./extras.nix
  ];

  personal = {
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
      printing = {
        enable = config.personal.services.enable;
      };
      tailscale = {
        enable = config.personal.services.enable;
      };
    };

    programs = {
      browser = {
        enable = config.personal.programs.enable;
      };
      lutris = {
        enable = config.personal.programs.enable;
      };
      mail = {
        enable = config.personal.programs.enable;
      };
      password = {
        enable = config.personal.programs.enable;
      };
      steam = {
        enable = config.personal.programs.enable;
      };
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
