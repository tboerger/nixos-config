{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.irc;

in
{
  options = {
    profile = {
      programs = {
        irc = {
          enable = mkEnableOption "IRC";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        srain
      ];
    };
  };
}
