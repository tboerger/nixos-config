{ pkgs, lib, config, options, ... }:
with lib;

{
  config = {
    security = {
      sudo = {
        wheelNeedsPassword = false;
      };
    };
  };
}
