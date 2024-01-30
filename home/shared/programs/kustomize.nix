{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.kustomize;

in
{
  options = {
    profile = {
      programs = {
        kustomize = {
          enable = mkEnableOption "Kustomize";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        khelm
        ksops
        kustomize
      ];
    };
  };
}
