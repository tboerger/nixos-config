{ pkgs, lib, config, options, ... }:
with lib;

{
  imports = [
    ./acme.nix
    ./auth.nix
    ./desktop.nix
    ./docker.nix
    ./hass.nix
    ./homedns.nix
    ./libvirt.nix
    ./minecraft.nix
    ./printing.nix
    ./shares.nix
    ./tailscale.nix
    ./webserver.nix

    ./archive
    ./cloud
    ./gallery
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
