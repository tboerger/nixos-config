{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.mailspring;

in
{
  options = {
    profile = {
      programs = {
        mailspring = {
          enable = mkEnableOption "Mailspring";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        mailspring
      ];
    };
  };
}
