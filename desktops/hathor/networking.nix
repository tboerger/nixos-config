{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "hathor";

    networkmanager = {
      enable = true;
    };
  };
}
