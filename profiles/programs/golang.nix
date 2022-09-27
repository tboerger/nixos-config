{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.golang;

in
{
  options = {
    profile = {
      programs = {
        golang = {
          enable = mkEnableOption "Golang";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.profile.username}" = { config, ... }: {
      programs = {
        go = {
          enable = true;
          package = pkgs.unstable.go_1_19;
          goPath = "Golang";
          goBin = "Golang/bin";

          # add delve to system packages
        };
      };
    };
  };
}
