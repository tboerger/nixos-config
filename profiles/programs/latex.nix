{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.latex;

in
{
  options = {
    profile = {
      programs = {
        latex = {
          enable = mkEnableOption "Latex";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        texlive = {
          enable = true;
        };
      };
    };
  };
}
