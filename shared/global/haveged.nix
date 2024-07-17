{ pkgs, lib, config, options, ... }:
with lib;

{
  config = {
    services = {
      haveged = {
        enable = true;
      };
    };
  };
}
