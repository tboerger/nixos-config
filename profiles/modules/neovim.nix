{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.neovim;

in

{
  options = with lib; {
    my = {
      modules = {
        neovim = {
          enable = mkEnableOption ''
            Whether to enable neovim module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      home-manager.users."${config.my.username}" = { config, ... }: {
        programs = {
          neovim = {
            enable = true;
          };
        };
      };
    };
}
