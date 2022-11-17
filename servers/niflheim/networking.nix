{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "niflheim";
    defaultGateway = "176.9.93.193";
    defaultGateway6 = "fe80::1";

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
