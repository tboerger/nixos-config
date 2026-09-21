{
  pkgs,
  lib,
  config,
  options,
  ...
}:

{
  imports = [
    ./prowlarr.nix
  ];
}
