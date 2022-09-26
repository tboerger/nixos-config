{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "vanaheim";
    defaultGateway = "192.168.1.1";

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    interfaces = {
      eth0 = {
        ipv4 = {
          addresses = [{
            address = "192.168.1.6";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
