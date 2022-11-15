{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./global
    ./network
    ./nixpkgs
    ./shells
    ./sudo
    ./tools
    ./users
  ];
}
