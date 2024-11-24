{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "utgard";
    defaultGateway = "192.168.1.1";
    usePredictableInterfaceNames = false;

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    interfaces = {
      eth0 = {
        ipv4 = {
          addresses = [{
            address = "192.168.1.11";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
