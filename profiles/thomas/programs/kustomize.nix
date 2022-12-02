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
    home-manager.users."${config.profile.username}" = { config, ... }: {
      xdg = {
        configFile = {
          "kustomize/plugin/viaduct.ai/v1/ksops/ksops" = {
            source = "${pkgs.kustomize-sops}/lib/viaduct.ai/v1/ksops-exec/ksops-exec";
          };
        };
      };
    };
  };
}
