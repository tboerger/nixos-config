{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.openssh;

in

{
  options = with lib; {
    my = {
      modules = {
        openssh = {
          enable = mkEnableOption ''
            Whether to enable openssh module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      services = {
        openssh = {
          enable = true;
          permitRootLogin = "yes";
        };
      };
    };
}
