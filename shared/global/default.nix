{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./general.nix
    ./haveged.nix
    ./network.nix
    ./nixpkgs.nix
    ./openssh.nix
    ./shells.nix
    ./sudo.nix
    ./timesyncd.nix
    ./users.nix
  ];
}
