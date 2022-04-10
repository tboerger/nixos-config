{ pkgs, lib, config, options, ... }:

{
  config = with lib; {
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
