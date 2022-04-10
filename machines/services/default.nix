{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./acme.nix
    ./dyndns.nix
    ./haveged.nix
    ./media.nix
    ./openssh.nix
    ./timesyncd.nix
    ./unifi.nix
    ./webserver.nix
  ];

  options = {
    personal = {
      services = { };
    };
  };
}
