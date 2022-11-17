{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./acme
    ./adguard
    ./authentik
    ./coredns
    ./desktop
    ./docker
    ./dst
    ./hass
    ./haveged
    ./libvirt
    ./media
    ./mediang
    ./minecraft
    ./nextcloud
    ./nixbuild
    ./openssh
    ./shares
    ./tailscale
    ./timesyncd
    ./webserver
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
