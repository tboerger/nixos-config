{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.jq;

in
{
  options = {
    profile = {
      programs = {
        jq = {
          enable = mkEnableOption "Jq";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        jq
      ];
    };
  };
}
