{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.lastpass;

in
{
  options = {
    profile = {
      programs = {
        lastpass = {
          enable = mkEnableOption "Lastpass";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        lastpass-cli
      ];
    };
  };
}
