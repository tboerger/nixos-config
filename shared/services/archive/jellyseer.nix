{ pkgs, config, lib, ... }:
with lib;

{
  services = {
    jellyseerr = {
      enable = true;
    };
  };
}
