{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.yq;

in
{
  options = {
    profile = {
      programs = {
        yq = {
          enable = mkEnableOption "Yq";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        yq-go
      ];
    };
  };
}
