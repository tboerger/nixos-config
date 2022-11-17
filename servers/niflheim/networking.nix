{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "niflheim";

    defaultGateway = {
      address = "176.9.93.193";
      interface = "enp3s0";
    };

    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp3s0";
    };

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      "2a01:4ff:ff00::add:1"
      "2a01:4ff:ff00::add:2"
    ];

    interfaces = {
      enp3s0 = {
        ipv4 = {
          addresses = [{
            address = "176.9.93.214";
            prefixLength = 27;
          }];
        };

        ipv6 = {
          addresses = [{
            address = "2a01:4f8:151:34ba::2";
            prefixLength = 64;
          }];
        };
      };
    };
  };
}
