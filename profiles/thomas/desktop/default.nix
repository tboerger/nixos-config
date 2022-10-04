{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./i3.nix
  ];

  options = {
    profile = {
      desktop = { };
    };
  };
}
