{ pkgs, lib, config, options, ... }:

{
  imports = [
    ./filebrowser.nix
    ./prowlarr.nix
  ];
}
