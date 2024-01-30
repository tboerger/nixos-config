{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./global.nix
    ./network.nix
    ./nixpkgs.nix
    ./shells.nix
    ./sudo.nix
    ./users.nix
  ];
}
