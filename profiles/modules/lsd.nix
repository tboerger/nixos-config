{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.lsd;

in

{
  options = with lib; {
    my = {
      modules = {
        lsd = {
          enable = mkEnableOption ''
            Whether to enable lsd module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      home-manager.users."${config.my.username}" = { config, ... }: {
        programs = {
          lsd = {
            enable = true;
            enableAliases = true;
          };
        };
      };
    };
}
