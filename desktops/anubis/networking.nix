{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "anubis";

    networkmanager = {
      enable = true;
    };

    # nat = {
    #   enable = true;
    #   enableIPv6 = true;
    #   internalInterfaces = [ "ve-+" ];
    #   externalInterface = "";
    # };
  };
}
