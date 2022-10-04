{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./acme.nix
    ./citrix.nix
    ./desktop.nix
    ./docker.nix
    ./frpc.nix
    ./haveged.nix
    ./libvirt.nix
    ./media.nix
    ./nixbuild.nix
    ./openssh.nix
    ./timesyncd.nix
    ./webserver.nix
  ];

  options = {
    personal = {
      services = { };
    };
  };
}
