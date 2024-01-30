{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.direnv;

in
{
  options = {
    profile = {
      programs = {
        direnv = {
          enable = mkEnableOption "Direnv" // {
            default = true;
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

        nix-direnv = {
          enable = true;
        };
      };
    };
  };
}
