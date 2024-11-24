{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.office;

in
{
  options = {
    profile = {
      programs = {
        office = {
          enable = mkEnableOption "Office";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        onlyoffice-bin
      ];
    };
  };
}
