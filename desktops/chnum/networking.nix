{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "chnum";

    networkmanager = {
      enable = true;
    };

    # nat = {
    #   enable = true;
    #   enableIPv6 = true;
    #   internalInterfaces = [ "ve-+" ];
    #   externalInterface = "enp0s25";
    # };
  };
}
