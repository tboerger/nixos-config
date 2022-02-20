{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.haveged;

in

{
  options = with lib; {
    my = {
      modules = {
        haveged = {
          enable = mkEnableOption ''
            Whether to enable haveged module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      services = {
        haveged = {
          enable = true;
        };
      };
    };
}
