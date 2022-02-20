{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.shells;

in

{
  options = with lib; {
    my = {
      modules = {
        shells = {
          enable = mkEnableOption ''
            Whether to enable shells module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      programs = {
        zsh = {
          enable = true;
        };
      };
    };
}
