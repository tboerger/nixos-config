{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.authy;

in
{
  options = {
    profile = {
      programs = {
        authy = {
          enable = mkEnableOption "Authy";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        authy
      ];
    };
  };
}
