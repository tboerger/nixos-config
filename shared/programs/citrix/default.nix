{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.personal.programs.citrix;

in
{
  options = {
    personal = {
      programs = {
        citrix = {
          enable = mkEnableOption "Citrix";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        citrix_workspace
      ];
    };
  };
}
