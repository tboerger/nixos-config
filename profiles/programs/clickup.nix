{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.clickup;

in
{
  options = {
    profile = {
      programs = {
        clickup = {
          enable = mkEnableOption "ClickUp";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        clickup
      ];
    };
  };
}
