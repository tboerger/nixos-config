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
    programs = {
      autorandr = {
        enable = true;

        profiles = { };
      };
    };

    services = {
      autorandr = {
        enable = true;
      };
    };
  };
}
