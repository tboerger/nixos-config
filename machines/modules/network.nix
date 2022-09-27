{ pkgs, lib, config, options, ... }:
with lib;

{
  config = {
    programs = {
      iftop = {
        enable = true;
      };

      iotop = {
        enable = true;
      };

      mtr = {
        enable = true;
      };
    };
  };
}
