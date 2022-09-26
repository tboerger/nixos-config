{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "niflheim";
    defaultGateway = "192.168.1.1";

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    interfaces = {
      eth0 = {
        ipv4 = {
          addresses = [{
            address = "192.168.1.7";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
