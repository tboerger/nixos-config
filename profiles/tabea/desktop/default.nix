{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./gnome.nix
  ];

  options = {
    profile = {
      desktop = { };
    };
  };
}
