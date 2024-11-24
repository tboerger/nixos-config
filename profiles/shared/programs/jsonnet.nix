{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.jsonnet;

in
{
  options = {
    profile = {
      programs = {
        jsonnet = {
          enable = mkEnableOption "Jsonnet";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        go-jsonnet
        jsonnet-bundler
      ];
    };
  };
}
