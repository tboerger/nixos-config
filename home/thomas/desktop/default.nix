{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./gnome.nix
    ./i3.nix
    ./sway.nix
  ];

  options = {
    profile = {
      desktop = { };
    };
  };
}
