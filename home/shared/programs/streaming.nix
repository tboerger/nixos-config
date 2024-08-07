{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.streaming;

in
{
  options = {
    profile = {
      programs = {
        streaming = {
          enable = mkEnableOption "Streaming";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        obs-studio
      ];
    };
  };
}
