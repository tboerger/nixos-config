{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.feh;

in
{
  options = {
    profile = {
      programs = {
        feh = {
          enable = mkEnableOption "Feh" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        feh = {
          enable = true;
        };
      };
    };
  };
}
