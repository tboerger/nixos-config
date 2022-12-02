{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./acme
    ./authentik
    ./homedns
    ./desktop
    ./docker
    ./hass
    ./haveged
    ./libvirt
    ./media
    ./minecraft
    ./nextcloud
    ./nixbuild
    ./openssh
    ./printing
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
