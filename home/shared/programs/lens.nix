{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.lens;

in
{
  options = {
    profile = {
      programs = {
        lens = {
          enable = mkEnableOption "Lens";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        lens
      ];
    };
  };
}
