{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./dunst.nix
    ./polybar.nix
  ];
}
