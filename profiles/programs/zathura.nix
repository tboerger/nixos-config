{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.zathura;

in
{
  options = {
    profile = {
      programs = {
        zathura = {
          enable = mkEnableOption "Zathura";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        zathura = {
          enable = true;
        };
      };
    };
  };
}
