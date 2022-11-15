{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "niflheim";
    defaultGateway = "192.168.64.1";

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    interfaces = {
      enp0s1 = {
        ipv4 = {
          addresses = [{
            address = "192.168.64.4";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
