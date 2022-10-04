{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.signal;

in
{
  options = {
    profile = {
      programs = {
        signal = {
          enable = mkEnableOption "Signal";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        signal-desktop
      ];
    };
  };
}
