{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.citrix;

in
{
  options = {
    profile = {
      programs = {
        citrix = {
          enable = mkEnableOption "Citrix";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        citrix_workspace
      ];
    };
  };
}
