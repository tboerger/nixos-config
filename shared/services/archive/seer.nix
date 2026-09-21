{
  pkgs,
  config,
  lib,
  ...
}:
with lib;

{
  services = {
    seerr = {
      enable = true;
    };
  };
}
