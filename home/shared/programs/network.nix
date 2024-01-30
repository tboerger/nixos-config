{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.network;

in
{
  options = {
    profile = {
      programs = {
        network = {
          enable = mkEnableOption "Network";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        httpie
        iftop
        nmap
      ];
    };
  };
}
