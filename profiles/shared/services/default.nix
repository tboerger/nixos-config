{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./nextcloud.nix
    ./syncthing.nix
    ./udiskie.nix
  ];

  options = {
    profile = {
      services = { };
    };
  };
}
