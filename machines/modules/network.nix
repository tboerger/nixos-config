{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.network;

in

{
  options = with lib; {
    my = {
      modules = {
        network = {
          enable = mkEnableOption ''
            Whether to enable network module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
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
