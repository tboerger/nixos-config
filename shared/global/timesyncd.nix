{ pkgs, lib, config, options, ... }:
with lib;

{
  config = {
    services = {
      timesyncd = {
        enable = true;
      };
    };
  };
}
