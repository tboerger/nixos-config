{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.autorandr;

in
{
  options = {
    profile = {
      programs = {
        autorandr = {
          enable = mkEnableOption "Autorandr";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        autorandr = {
          enable = true;

          profiles = {
            solo = { };

            desk = { };
          };
        };
      };
    };
  };
}
