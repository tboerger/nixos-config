{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "anubis";

    networkmanager = {
      enable = true;
    };
  };
}
