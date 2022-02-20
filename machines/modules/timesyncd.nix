{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.timesyncd;

in

{
  options = with lib; {
    my = {
      modules = {
        timesyncd = {
          enable = mkEnableOption ''
            Whether to enable timesyncd module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      services = {
        timesyncd = {
          enable = true;
        };
      };
    };
}
