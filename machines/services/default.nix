{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./acme.nix
    ./adguard.nix
    ./citrix.nix
    ./coredns.nix
    ./desktop.nix
    ./docker.nix
    ./hacking.nix
    ./hass.nix
    ./haveged.nix
    ./libvirt.nix
    ./media.nix
    ./nixbuild.nix
    ./openssh.nix
    ./shares.nix
    ./tailscale.nix
    ./timesyncd.nix
    ./webserver.nix
  ];

  options = {
    personal = {
      services = {
        enable = mkEnableOption "Services" // {
          default = true;
        };
      };
    };
  };
}
