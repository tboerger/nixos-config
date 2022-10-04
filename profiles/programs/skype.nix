{ pkgs, lib, config, options, ... }:
with lib;

let
  cfg = config.profile.programs.skype;

in
{
  options = {
    profile = {
      programs = {
        skype = {
          enable = mkEnableOption "Skype";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        skypeforlinux
      ];
    };
  };
}
