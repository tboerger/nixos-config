{ config, lib, pkgs, ... }:

{
  imports = [
    ../../shared/modules
    ../../shared/programs
    ../../shared/services

    ./disko.nix
    ./boot.nix
    ./networking.nix
    ./hardware.nix
    ./extras.nix
  ];

  age = {
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };

  personal = {
    services = {
      cloud = {
        enable = config.personal.services.enable;
      };
      gallery = {
        enable = config.personal.services.enable;
      };
      archive = {
        enable = config.personal.services.enable;
      };
      auth = {
        enable = config.personal.services.enable;
      };
      minecraft = {
        enable = config.personal.services.enable;
      };
      tailscale = {
        enable = config.personal.services.enable;
      };
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
