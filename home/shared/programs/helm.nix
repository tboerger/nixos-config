{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.helm;

in
{
  options = {
    profile = {
      programs = {
        helm = {
          enable = mkEnableOption "Helm";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        chart-testing
        helm-docs
        kubernetes-helm
      ];
    };
  };
}
