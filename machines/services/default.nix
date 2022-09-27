{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./acme.nix
    ./desktop.nix
    ./docker.nix
    ./haveged.nix
    ./libvirt.nix
    ./media.nix
    ./nixbuild.nix
    ./openssh.nix
    ./proxy.nix
    ./timesyncd.nix
    ./webserver.nix
  ];

  options = {
    personal = {
      services = { };
    };
  };
}
