{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "vanaheim";
    defaultGateway = "";
    usePredictableInterfaceNames = false;

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    interfaces = {
      eth0 = {
        ipv4 = {
          addresses = [{
            address = "";
            prefixLength = 24;
          }];
        };
      };
    };

    nat = {
      enable = true;
      enableIPv6 = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "eth0";
    };
  };
}
