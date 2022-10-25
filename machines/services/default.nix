{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./acme.nix
    ./adguard.nix
    ./citrix.nix
    ./coredns.nix
    ./desktop.nix
    ./docker.nix
    ./hass.nix
    ./haveged.nix
    ./libvirt.nix
    ./media.nix
    ./nixbuild.nix
    ./openssh.nix
    ./samba.nix
    ./tailscale.nix
    ./timesyncd.nix
    ./webserver.nix
  ];

  options = {
    personal = {
      services = { };
    };
  };
}
