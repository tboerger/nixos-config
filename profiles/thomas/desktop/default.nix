{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./gnome.nix
    ./i3.nix
  ];

  options = {
    profile = {
      desktop = { };
    };
  };
}
