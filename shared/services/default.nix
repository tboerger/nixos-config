{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./acme.nix
    ./auth.nix
    ./desktop.nix
    ./docker.nix
    ./gallery.nix
    ./hass.nix
    ./haveged.nix
    ./homedns.nix
    ./libvirt.nix
    ./media.nix
    ./minecraft.nix
    ./openssh.nix
    ./printing.nix
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
