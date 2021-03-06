{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "asgard";
    defaultGateway = "192.168.1.1";

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

    interfaces = {
      enp2s0f0 = {
        ipv4 = {
          addresses = [{
            address = "192.168.1.10";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
